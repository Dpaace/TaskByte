import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart';
import 'package:provider/provider.dart';

import '../model/events.dart';
import '../model/subscription_models.dart';

export 'package:provider/provider.dart';

const String kLocalhost = 'http://localhost:5000';
// const String kLocalhost = 'http://192.168.1.18:5000';

///Converts `enum` to `String`
String enumToString(enum1) {
  return enum1.toString().split(".").last;
}

///Error indicates that the user didn't connect to the socket
class NotConnected implements Exception {}

///Error indicates that the user didn't subscribe to a room
class NotSubscribed implements Exception {}

/// Incoming Events
///
/// see also:
/// - enum `OUTEvent`
/// - `Node.js` Server code.
enum INEvent {
  newUserToChatRoom,
  userLeftChatRoom,
  updateChat,
  typing,
  stopTyping,
}

/// Outgoing Events
///
/// see also:
/// - enum `INEvent`
/// - `Node.js` Server code.
enum OUTEvent {
  subscribe,
  unsubscribe,
  newMessage,
  typing,
  stopTyping,
}

typedef DynamicCallback = void Function(dynamic data);

class SocketController {
  ///Get a provider instatnce of the class
  ///
  ///if you want to call this method in `initState` method, remember to call after the first frame.
  ///
  ///example:
  ///```
  /// WidgetsBinding.instance?.addPostFrameCallback((_) {
  ///     SocketController.get(context)
  ///       ..init()
  ///       ..connect();
  /// });
  ///```
  static SocketController get(BuildContext context) =>
      context.read<SocketController>();

  Socket? _socket;
  Subscription? _subscription;

  StreamController<List<ChatEvent>>? _newMessagesController;
  List<ChatEvent>? _events;

  ///Current user room subscription
  Subscription? get subscription => _subscription;

  ///`Boolean` represents the state of the socket if it is currently connected.
  bool get connected => _socket!.connected;

  ///`Boolean` represents the state of the socket if it is currently diconnected form the server.
  bool get disConnected => !connected;

  ///Returns a stream with the chat messages.
  Stream<List<ChatEvent>>? get watchEvents =>
      _newMessagesController?.stream.asBroadcastStream();

  /// Initializes the controller and its streams
  ///
  /// see also:
  /// - `connect()`
  void init({String? url}) {
    _socket ??= io(
      url ?? _localhost,
      OptionBuilder().setTransports(['websocket']).disableAutoConnect().build(),
    );
    _newMessagesController ??= StreamController<List<ChatEvent>>.broadcast();
    _events = [];
  }

  ///initializes the events listeners and sends the events to the stream controller sink
  void _initListeners() {
    _connectedAssetion();
    final socket = _socket!;

    socket.on(enumToString(INEvent.newUserToChatRoom), (data) {
      final user = ChatUser.fromMap(data, chatUserEvent: ChatUserEvent.joined);
      _newUserEvent(user);
    });

    socket.on(enumToString(INEvent.userLeftChatRoom), (data) {
      final user = ChatUser.fromMap(data, chatUserEvent: ChatUserEvent.left);
      _newUserEvent(user);
    });

    socket.on(enumToString(INEvent.updateChat), (response) {
      final message = Message.fromJson(response);
      _addNewMessage(message);
    });

    socket.on(enumToString(INEvent.typing), (_) {
      _addTypingEvent(UserStartedTyping());
    });

    socket.on(enumToString(INEvent.stopTyping), (_) {
      _addTypingEvent(UserStoppedTyping());
    });
  }

  ///Connects the device to the socket and initializes all the event listeners
  ///
  /// @Params:
  /// - `onConnectionError`: socket error callback method.
  /// - `connected`: socket conection success callback method.
  Socket connect(
      {DynamicCallback? onConnectionError, VoidCallback? connected}) {
    assert(_socket != null, "Did you forget to call `init()` first?");

    final socketS = _socket!.connect();

    _socket!.onConnect((_) {
      _initListeners();
      connected?.call();
      log("Connected to Socket");
    });

    _socket!.onConnectError((data) => onConnectionError?.call(data));
    return socketS;
  }

  ///Disconnects the device from the socket.
  ///
  /// @Params:
  /// - `disconnected`: socket disconection success callback method.
  Socket disconnect({VoidCallback? disconnected}) {
    final socketS = _socket!.disconnect();
    _socket!.onDisconnect((_) {
      disconnected?.call();
      log("Disconnected");
    });
    return socketS;
  }

  ///Subscribe to a room using `subscription`
  ///
  void subscribe(Subscription subscription, {VoidCallback? onSubscribe}) {
    _connectedAssetion();
    final socket = _socket!;
    socket.emit(
      enumToString(OUTEvent.subscribe),
      subscription.toMap(),
    );
    _subscription = subscription;
    onSubscribe?.call();
    log("Subscribed to ${subscription.roomName}");
  }

  ///unsubscribe from a room
  ///
  void unsubscribe({VoidCallback? onUnsubscribe}) {
    _connectedAssetion();
    if (_subscription == null) return;

    final socket = _socket!;

    socket
      ..emit(
        enumToString(OUTEvent.stopTyping),
        _subscription!.roomName,
      )
      ..emit(
        enumToString(OUTEvent.unsubscribe),
        _subscription!.toMap(),
      );

    final roomename = _subscription!.roomName;

    onUnsubscribe?.call();
    _subscription = null;
    _events?.clear();
    log("UnSubscribed from $roomename");
  }

  ///Sends a message to the users in the same room.
  ///
  void sendMessage(Message message) {
    _connectedAssetion();
    if (_subscription == null) throw NotSubscribed();
    final socket = _socket!;

    final message0 = message.copyWith(
      userName: subscription!.userName,
      roomName: subscription!.roomName,
    );

    //Stop typing then send new message.
    socket
      ..emit(
        enumToString(OUTEvent.stopTyping),
        _subscription!.roomName,
      )
      ..emit(
        enumToString(OUTEvent.newMessage),
        message0.toMap(),
      );

    _addNewMessage(message0);
  }

  ///Sends to the room that the current user is typing.
  void typing() {
    _connectedAssetion();
    if (_subscription == null) throw NotSubscribed();
    final socket = _socket!;
    socket.emit(enumToString(OUTEvent.typing), _subscription!.roomName);
  }

  //Informs the room members that tha current user has stopped typing.
  void stopTyping() {
    _connectedAssetion();
    if (_subscription == null) throw NotSubscribed();
    final socket = _socket!;
    socket.emit(enumToString(OUTEvent.stopTyping), _subscription!.roomName);
  }

  ///Disposes all the objects which have been initialized and resests the whole controller.
  void dispose() {
    _socket?.dispose();
    _newMessagesController?.close();
    _events?.clear();
    unsubscribe();

    _socket = null;
    _subscription = null;
    _newMessagesController = null;
    _events = null;
  }

  void _connectedAssetion() {
    assert(_socket != null, "Did you forget to call `init()` first?");
    if (disConnected) throw NotConnected();
  }

  void _addNewMessage(Message message) => _addEvent(message);

  void _newUserEvent(ChatUser user) => _addEvent(user);

  void _addTypingEvent(UserTyping event) {
    _events!.removeWhere((e) => e is UserTyping);
    _events = <ChatEvent>[event, ..._events!];
    _newMessagesController?.sink.add(_events!);
  }

  ///Add new event to the steam sink
  ///
  ///see also:
  /// * `watchEvents` getter
  void _addEvent(event) {
    _events = <ChatEvent>[event, ..._events!];
    _newMessagesController?.sink.add(_events!);
  }

  String get _localhost {
    final uri = Uri.parse(kLocalhost);

    if (Platform.isIOS) return kLocalhost;

    //Android local url
    return '${uri.scheme}://10.0.2.2:${uri.port}';
    // return '${uri.scheme}://192.168.1.18:${uri.port}';
    // http://192.168.1.18
  }
}
