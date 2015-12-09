// Copyright 2015, the Flutter authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:sky_services/gcm/gcm.mojom.dart';

GcmServiceProxy _initGcmService() {
  GcmServiceProxy gcmService = new GcmServiceProxy.unbound();
  shell.connectToService(null, gcmService);
  return gcmService;
}

final GcmServiceProxy _gcmService = _initGcmService();

void registerGcmService(String senderId) {
  GcmListenerStub listener = new GcmListenerStub.unbound();
   // ..impl = new GcmListenerDerived() (see RawKeyboardListener)
  _gcmService.ptr.register(senderId, listener, (String x) { });
}
