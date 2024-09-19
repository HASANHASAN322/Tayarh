import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TripModel {
  final String tripId;
  final String driverId;
  final String userId;
  final String status;
  final String cost;
  final GeoPoint startPoint;
  final GeoPoint endPoint;
  final DateTime timestamp; // New field for time

  TripModel(
      {
    this.tripId = '',
        this.status = '',
    required this.driverId,
    required this.userId,
    required this.cost,
    required this.startPoint,
    required this.endPoint,
    required this.timestamp,
  });

  // Create a TripModel from a JSON map
  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      tripId: json['tripId'] ?? '',
      driverId: json['driverId'],
      userId: json['userId'],
      cost: json['cost'],
      startPoint: json['startPoint'],
      endPoint: json['endPoint'],
      timestamp: json['timestamp'],
      status: 'waiting',
    );
  }

  // Convert a TripModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'status' : status ,
      'tripId': tripId,
      'driverId': driverId,
      'userId': userId,
      'cost': cost,
      'startPoint': startPoint,
      'endPoint': endPoint,
      'timestamp': timestamp,
    };
  }
}
