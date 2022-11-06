import unreal

assetRegistry = unreal.AssetRegistryHelpers().get_asset_registry();

allAssets = assetRegistry.get_assets(unreal.ARFilter(package_paths=["/Game/"], recursive_paths=True))
allAssetsCount = len(allAssets)
unreal.log("Scanning " + str(allAssetsCount) + " assets for resave.")
if (allAssetsCount > 0):
    with unreal.ScopedSlowTask(allAssetsCount, "Scanning") as slowTask:
        slowTask.make_dialog(True)
        for asset in allAssets:
            asset_path = asset.object_path
            if not asset.is_asset_loaded():
                if slowTask.should_cancel():
                    break
                slowTask.enter_progress_frame(1, asset_path)
                continue
            unreal.EditorAssetLibrary.save_asset(asset_path, False)
            if slowTask.should_cancel():
                break
            slowTask.enter_progress_frame(1, asset_path)
