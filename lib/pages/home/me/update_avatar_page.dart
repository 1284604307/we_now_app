import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as image;
import 'package:extended_image/extended_image.dart';


/**
 * @createDate  2020/5/6
 */
class UpdateAvatarPage extends StatefulWidget {

  File file;
  UpdateAvatarPage(this.file);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _State(file);
  }

}

class _State extends State<UpdateAvatarPage>{

  File file;
  _State(this.file);

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
//              Image src = await image.isolateDecodeImage(data);
//              Image src = await lb.run<Image, List<int>>(decodeImage, data);

            },
          ),
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
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

}
