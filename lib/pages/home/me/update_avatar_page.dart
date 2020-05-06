import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app2/pages/wights/page_route_anim.dart';
import 'package:flutter_app2/services/model/viewModel/user_model.dart';
import 'package:flutter_app2/services/net/restful_go.dart';
import 'package:image/image.dart' as imageUtil;
import 'package:extended_image/extended_image.dart';
import 'package:image_editor/image_editor.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';


/**
 * @createDate  2020/5/6
 */
class UpdateAvatarPage extends StatefulWidget {

  File file;
  UpdateAvatarPage(this.file);

  @override
  State<StatefulWidget> createState() {
    return _State(file);
  }

}

class _State extends State<UpdateAvatarPage>{

  File file;
  _State(this.file);
  bool croped = false;

  final GlobalKey<ExtendedImageEditorState> editorKey =GlobalKey<ExtendedImageEditorState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("裁剪头像"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.image),
            onPressed: () async {
              File f = await cropAndSave();
              setState(() {
                file = f;
                croped = true;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () async{
              if(croped)
                await RestfulApi.updateAvatar(file);
              else{
                File f = await cropAndSave();
                await RestfulApi.updateAvatar(f);
              }
              showToast("上传成功");
              await Provider.of<UserModel>(context,listen: false).refreshInfo();
              Navigator.pop(context);
            },
          )
        ],
      ),
      body:ExtendedImage.file(
        file,
        fit: BoxFit.contain,
        mode: ExtendedImageMode.editor,
        extendedImageEditorKey: editorKey,
        initEditorConfigHandler: (state) {
          return EditorConfig(
              maxScale: 8.0,
              cropRectPadding: EdgeInsets.all(20.0),
              hitTestSize: 20.0,
              lineColor:Colors.lightBlueAccent,
              cropAspectRatio: CropAspectRatios.ratio1_1
          );
        },
      ),
    );
  }

  cropAndSave() async{
    ExtendedImageEditorState state = editorKey.currentState;
    var action= state.editAction;
    final Rect cropRect = state.getCropRect();
    final img = state.rawImageData;
    final rotateAngle = action.rotateAngle.toInt();
    final flipHorizontal = action.flipY;
    final flipVertical = action.flipX;
    ImageEditorOption option = ImageEditorOption();
    if (action.needCrop) option.addOption(ClipOption.fromRect(cropRect));
    if (action.needFlip)
      option.addOption(
          FlipOption(horizontal: flipHorizontal, vertical: flipVertical));
    if (action.hasRotateAngle) option.addOption(RotateOption(rotateAngle));
    final result = await ImageEditor.editImage(
      image: img,
      imageEditorOption: option,
    );
    var path = await getApplicationDocumentsDirectory();
    File f = File("${path.path}/WE_NOW${DateTime.now().microsecondsSinceEpoch}.png");
    await f.writeAsBytes(result);
    croped = true;
    return f;
  }

}
