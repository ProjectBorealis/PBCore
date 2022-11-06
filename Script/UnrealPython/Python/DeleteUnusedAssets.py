#										_
#									   (_)
#  _ __ ___   __ _ _ __ ___   ___  _ __  _  ___ _ __ ___
# | '_ ` _ \ / _` | '_ ` _ \ / _ \| '_ \| |/ _ \ '_ ` _ \
# | | | | | | (_| | | | | | | (_) | | | | |  __/ | | | | |
# |_| |_| |_|\__,_|_| |_| |_|\___/|_| |_|_|\___|_| |_| |_|
#					www.mamoniem.com
#					  www.ue4u.xyz
#Copyright 2019 Muhammad A.Moniem (@_mamoniem). All Rights Reserved.
#

import unreal

workingPath = "/Game/Imported/materials"

@unreal.uclass()
class GetEditorAssetLibrary(unreal.EditorAssetLibrary):
    pass

editorAssetLib = GetEditorAssetLibrary();

allAssets = editorAssetLib.list_assets(workingPath, True, False)

processingAssetPath = ""
allAssetsCount = len(allAssets)
if ( allAssetsCount > 0):
    with unreal.ScopedSlowTask(allAssetsCount, processingAssetPath) as slowTask:
        slowTask.make_dialog(True)
        for asset in allAssets:
            processingAssetPath = asset
            deps = editorAssetLib.find_package_referencers_for_asset(asset, False)
            if (len(deps) <= 0):
                editorAssetLib.delete_asset(asset)
            if slowTask.should_cancel():
                break
            slowTask.enter_progress_frame(1, processingAssetPath)