import unreal
import csv

assetRegistry = unreal.AssetRegistryHelpers().get_asset_registry();

allAssets = assetRegistry.get_assets(unreal.ARFilter(class_names=["StaticMesh", "MaterialInstanceConstant", "Material"], package_paths=["/Game/"], recursive_paths=True))
allAssetsCount = len(allAssets)
unreal.log("Scanning " + str(allAssetsCount) + " assets for physics materials.")
if (allAssetsCount > 0):
    with open(unreal.Paths().project_saved_dir() + 'asset_phys.csv', 'wb') as csvfile:
        csvwriter = csv.writer(csvfile)
        csvwriter.writerow(['Type', 'Asset', 'Physics'])
        with unreal.ScopedSlowTask(allAssetsCount, "Scanning") as slowTask:
            slowTask.make_dialog(True)
            row = ["", "", ""]
            for asset in allAssets:
                asset_path = asset.object_path
                if not asset.is_asset_loaded():
                    if slowTask.should_cancel():
                        break
                    slowTask.enter_progress_frame(1, asset_path)
                    continue
                asset_obj = asset.get_asset()
                if type(asset_obj) == unreal.StaticMesh:
                    phys_mat_container = asset_obj.get_editor_property("body_setup")
                else:
                    phys_mat_container = asset_obj
                phys_mat = phys_mat_container.get_editor_property("phys_material")
                if phys_mat:
                    phys_mat_name = phys_mat.get_path_name()
                else:
                    phys_mat_name = "None"
                row[0] = asset.asset_class
                row[1] = asset_path
                row[2] = phys_mat_name
                csvwriter.writerow(row)
                if slowTask.should_cancel():
                    break
                slowTask.enter_progress_frame(1, asset_path)
