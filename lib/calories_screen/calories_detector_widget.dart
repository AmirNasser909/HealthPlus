import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fitness_app/DataSets/food_dataset.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdownfield/dropdownfield.dart';

class CaloriesDetectorWidget extends StatefulWidget {
  @override
  _CaloriesDetectorState createState() => _CaloriesDetectorState();
}

const String ssd = "SSD MobileNet";
const String yolo = "Tiny YOLOv2";

class _CaloriesDetectorState extends State<CaloriesDetectorWidget> {
  File _image;
  var ImageToBePredicted;
  String _model = ssd;
  double _imageWidth;
  double _imageHeight;
  bool _busy = false;
  List _recognitions = [];

  bool detectdFood = false;
  bool classHasTooManyTypes = false;
  String foodName;
  String foodCalories;

  List<String> pizzaOptions = [
    'cheesepizza',
    'meatpizza',
    'vegetablespizza',
    'pipronipizza',
    'margretapizza',
  ];

  String ChoosedOption;


  @override
  void initState() {
    _busy = true;
    loadModel().then((value) {
      setState(() {
        _busy = false;
      });
    });
    super.initState();
  }

  loadModel() async {
    Tflite.close();
    try {
      String res;
      if (_model == yolo) {
        res = await Tflite.loadModel(
          model: "assets/tflite/yolov2_tiny.tflite",
          labels: "assets/tflite/yolov2_tiny.txt",
        );
      } else if (_model == ssd) {
        res = await Tflite.loadModel(
          model: "assets/tflite/ssd_mobilenet.tflite",
          labels: "assets/tflite/ssd_mobilenet.txt",
        );
      }
      print(res + _model);
    } catch (e) {
      print("Failed to load the model");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<Widget> stackChildren = [];
    stackChildren.add(
      Positioned(
          width: MediaQuery.of(context).size.width,
          child: _image == null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              : Image.file(_image)),
    );

    stackChildren.addAll(renderBoxes(size));

    if (_busy) {
      stackChildren.add(Center(
        child: CircularProgressIndicator(),
      ));
    }

    if (detectdFood) {
      stackChildren.add(Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                foodName + " Detected",
                style: GoogleFonts.novaRound(
                    fontWeight: FontWeight.bold, fontSize: 30),
              )),
          Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                foodCalories,
                style: GoogleFonts.novaRound(
                    fontWeight: FontWeight.bold, fontSize: 15),
              )),
          SizedBox(
            height: 20,
          ),
        ],
      ));
    }


  /*  if(classHasTooManyTypes){
      stackChildren.add(Align(
        alignment: Alignment.topRight,
        child: RaisedButton(
          onPressed: (){
            Scaffold.of(context)
                .showBottomSheet(
                    (context) => Text("S"));
          },
          child: Text("Justify Type Of "+ foodName,style: TextStyle(color: Colors.black),),

        ),
      ));
    }*/
    return Container(
      decoration: BoxDecoration(
        color: Colors.black12,
        image: DecorationImage(
          image: AssetImage("assets/images/SHA5BET.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: () async {
                    try {
                      await ImagePicker.platform
                          .pickImage(source: ImageSource.camera)
                          .then((value) => ImageToBePredicted = File(value.path));
                    } catch (e) {
                      print(e);
                    }
                    _predictImage(ImageToBePredicted);
                  }),
              IconButton(
                  icon: Icon(Icons.photo),
                  onPressed: () async {
                    try {
                      await ImagePicker.platform
                          .pickImage(source: ImageSource.gallery)
                          .then((value) => ImageToBePredicted = File(value.path));
                    } catch (e) {
                      print(e);
                    }
                    _predictImage(ImageToBePredicted);
                  }),
            ],
          ),
          Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    image: DecorationImage(
                      image: AssetImage("assets/images/SHA5BET.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(children: stackChildren)),
        ],
      ),
    );
  }

  List<Widget> renderBoxes(Size size) {
    if (_recognitions == null) {
      return [];
    }
    if (_imageWidth == null || _imageHeight == null) {
      return [];
    }

    double factorX = size.width;
    double factorY = _imageHeight / _imageHeight * size.width;

    Color blue = Colors.blue;

    return _recognitions
        .map((re) => Positioned(
            left: re['rect']['x'] * factorX,
            top: re['rect']['y'] * factorY,
            width: re['rect']['w'] * factorX,
            height: re['rect']['h'] * factorY,
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: blue, width: 3),
                ),
                child: Text(
                  "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
                  style: TextStyle(
                    background: Paint()..color = blue,
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ))))
        .toList();
  }

  yolov2Tiny(File Image) async {
    var recognitions = await Tflite.detectObjectOnImage(
        path: Image.path,
        numResultsPerClass: 1,
        model: "YOLO",
        threshold: 0.3,
        imageMean: 0.0,
        imageStd: 255.0);
    setState(() {
      _recognitions = recognitions;
    });
  }

  MobileNet(File Image) async {
    try {
      var recognitions = await Tflite.detectObjectOnImage(
          path: Image.path, numResultsPerClass: 1);
      setState(() {
        _recognitions = recognitions;
      });
    } catch (e) {
      print(e);
    }
  }

  ssdMobileNet(File Image) async {
    try {
      var recognitions = await Tflite.detectObjectOnImage(
          path: Image.path, numResultsPerClass: 1);
      setState(() {
        _recognitions = recognitions;
      });
    } catch (e) {
      print(e);
    }
  }

  _predictImage(image) async {

    detectdFood = false;
    classHasTooManyTypes = false;
    if (image == null) return;

    if (_model == yolo) {
      await yolov2Tiny(image);
    } else if (_model == ssd) {
      await ssdMobileNet(image);
    } else {
      await MobileNet(image);
    }

    _getTheCalories(_recognitions);

    setState(() {
      _busy = true;
    });

    FileImage(ImageToBePredicted)
        .resolve(ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      setState(() {
        _imageWidth = info.image.width.toDouble();
        _imageHeight = info.image.height.toDouble();
      });
    }));

    setState(() {
      _image = ImageToBePredicted;
      _busy = false;
    });
  }

  void _getTheCalories(List recognitions) {
    print("Started Detecting Calories");
    print(recognitions.length);
    for (int i = 0; i < FoodDateSet.foodDataSet.length  ; i++) {
      for (int j = 0; j < recognitions.length; j++) {
        if (recognitions[j]['detectedClass'] ==
            FoodDateSet.foodDataSet[i].foodItemTitle) {
            detectdFood = true;
            foodName = FoodDateSet.foodDataSet[i].foodItemTitle;
            foodCalories = FoodDateSet.foodDataSet[i].foodItemCaloreis;
            if(foodName == "pizza" || foodName == "sandwich" || foodName == "cake"){
                classHasTooManyTypes = true;
            }
        }
      }
    }
  }
}
