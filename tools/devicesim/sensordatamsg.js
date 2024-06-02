/*
  File: sensordatamsg.js

  Description:
  Main etry point for the devicesim tool.

  License:
  Intel TODO

*/

'use strict';

var USEID = "1600";

const Northsouth = require('cccommon/northsouth');

exports.get = function() {
  return {
    data: {
      time: Date.now(),
      gatewayId: "rapid_test_01",
      shipmentId: USEID,
      messageToken: "testtoken",
      location: {
        latitude: 45.540065,
        longitude: -122.610528,
        altitude: 16,
        positionUncertainty: 5,
        locationMethod: "NoPosition",
        timeOfPosition: Date.now(),
                          "cellTowers": [
                        {
                            "cellId": 14683346,
                            "locationAreaCode": 33981,
                            "mobileCountryCode": 310,
                            "mobileNetworkCode": 410,
                            "signalStrength": 7
                        }
                    ]},
      IsEncrypted: "No",
      Payload: [{
          //first tag
          TagId: '201',
          Sensordata: [{
              "type": "light",
              "isAnalysis": "true",
              "isAnomaly": "false",
              "currentValue": 1,
              "anomalyValue": 0,
            },
            {
              "type": "humidity",
              "isAnalysis": "true",
              "isAnomaly": "false",
              "currentValue": 2,
              "anomalyValue": 0,
            },
            {
              "type": "temperature",
              "isAnalysis": "true",
              "isAnomaly": "false",
              "currentValue": 3,
              "anomalyValue": 0,
            },
            {
              "type": "pressure",
              "isAnalysis": "true",
              "isAnomaly": "false",
              "currentValue": 4,
              "anomalyValue": 0,
            },
            {
              "type": "battery",
              "isAnalysis": "true",
              "isAnomaly": "false",
              "currentValue": 5,
              "anomalyValue": 0,
            },
            {
              "type": "shock",
              "isAnalysis": "true",
              "isAnomaly": "false",
              "currentValue": 8000,
              "anomalyMinValue": 8,
              "anomalyMaxValue": 20,
              "anomalyCount": 0,
            },
            {
              "type": "tilt",
              "isAnalysis": "true",
              "isAnomaly": "false",
              "currentValue": 100,
              "anomalyValue": 0,
            },
          ]
        },
        {
          //second tag
          TagId: '202',
          Sensordata: [{
              "type": "light",
              "isAnalysis": "true",
              "isAnomaly": "false",
              "currentValue": 30,
              "anomalyValue": 0,
            },
            {
              "type": "humidity",
              "isAnalysis": "true",
              "isAnomaly": "false",
              "currentValue": 20,
              "anomalyValue": 0,
            },
            {
              "type": "temperature",
              "isAnalysis": "true",
              "isAnomaly": "false",
              "currentValue": 30,
              "anomalyValue": 0,
            },
            {
              "type": "pressure",
              "isAnalysis": "false",
              "isAnomaly": "true",
              "currentValue": 6000,
              "anomalyValue": 0,
            },
            {
              "type": "battery",
              "isAnalysis": "true",
              "isAnomaly": "false",
              "currentValue": 3000,
              "anomalyValue": 0,
            },
            {
              "type": "shock",
              "isAnalysis": "true",
              "isAnomaly": "false",
              "currentValue": 4000,
              "anomalyMinValue": 8,
              "anomalyMaxValue": 20,
              "anomalyCount": 0,
            },
            {
              "type": "tilt",
              "isAnalysis": "true",
              "isAnomaly": "false",
              "currentValue": 15,
              "anomalyValue": 0,
            },
          ]
        },
      ]
    },
    properties: {
      southnorth_msgid: Northsouth.northbound.msgids.sensordata,
      egg: "SensorData Message!",
    },
  };
};
