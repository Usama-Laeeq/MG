import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const TextFieldDecoration =  InputDecoration(
    filled: true,
    fillColor: Colors.white,
    border: InputBorder.none,
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide.none
    ),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide.none
    )
);