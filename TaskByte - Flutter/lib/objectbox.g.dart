// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'model/comments_model.dart';
import 'model/groups_model.dart';
import 'model/post_model.dart';
import 'model/user_model.dart';
import 'model/user_story_model.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(2, 1903004054893665018),
      name: 'UserStory',
      lastPropertyId: const IdUid(4, 7010093635171904585),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 289834711972582621),
            name: 'storyId',
            type: 6,
            flags: 129),
        ModelProperty(
            id: const IdUid(2, 5515001472532047021),
            name: 'sImage',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 3306868048729648404),
            name: 'sUserImage',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 7010093635171904585),
            name: 'sUserName',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(4, 6365472608543277415),
      name: 'User',
      lastPropertyId: const IdUid(10, 1972435106287003390),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 3469599677649436989),
            name: 'id',
            type: 6,
            flags: 129),
        ModelProperty(
            id: const IdUid(2, 4564525606748995346),
            name: 'userId',
            type: 9,
            flags: 2080,
            indexId: const IdUid(2, 5625829143363445910)),
        ModelProperty(
            id: const IdUid(3, 6996976949432037275),
            name: 'firstName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 1971062845097020762),
            name: 'lastName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 2353380127541876611),
            name: 'dateOfBirth',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 6682647132006904190),
            name: 'phoneNumber',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 1146741064853992582),
            name: 'image',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 6101335015659622064),
            name: 'email',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 8996537100709745758),
            name: 'password',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(10, 1972435106287003390),
            name: 'interests',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(5, 3407590026755651996),
      name: 'UserPost',
      lastPropertyId: const IdUid(10, 4223538451964837938),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 5758318609164445826),
            name: 'postId',
            type: 9,
            flags: 2080,
            indexId: const IdUid(3, 8640051546203470794)),
        ModelProperty(
            id: const IdUid(2, 3218889349110503285),
            name: 'postTime',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 2995091068872644041),
            name: 'description',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 1637581586406101554),
            name: 'image',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 820145036727163717),
            name: 'pid',
            type: 6,
            flags: 129),
        ModelProperty(
            id: const IdUid(10, 4223538451964837938),
            name: 'title',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(6, 9078443980584423107),
      name: 'Groups',
      lastPropertyId: const IdUid(6, 8810299322409522594),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(2, 1334517909123429161),
            name: 'groupId',
            type: 9,
            flags: 2080,
            indexId: const IdUid(4, 3864319496495589442)),
        ModelProperty(
            id: const IdUid(3, 8321328030318013555),
            name: 'groupName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 8810299322409522594),
            name: 'id',
            type: 6,
            flags: 129)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(8, 8570397301582175198),
      name: 'Comment',
      lastPropertyId: const IdUid(5, 1885901798592777364),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 3098951053358668908),
            name: 'cid',
            type: 6,
            flags: 129),
        ModelProperty(
            id: const IdUid(2, 6645948698191513346),
            name: 'commentId',
            type: 9,
            flags: 2080,
            indexId: const IdUid(6, 5469097344010151837)),
        ModelProperty(
            id: const IdUid(3, 4695999677920606134),
            name: 'userId',
            type: 11,
            flags: 520,
            indexId: const IdUid(7, 4758358432420593506),
            relationTarget: 'User'),
        ModelProperty(
            id: const IdUid(4, 2301682620620414970),
            name: 'postId',
            type: 11,
            flags: 520,
            indexId: const IdUid(8, 7239792566150089975),
            relationTarget: 'UserPost'),
        ModelProperty(
            id: const IdUid(5, 1885901798592777364),
            name: 'content',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(8, 8570397301582175198),
      lastIndexId: const IdUid(8, 7239792566150089975),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [
        5777762272966440622,
        8386385020198634455,
        5087349710689032133
      ],
      retiredIndexUids: const [],
      retiredPropertyUids: const [
        6505903199192010520,
        222202472855060176,
        5855801077369574074,
        2360314652418518032,
        5039705322381523732,
        3565269517405685513,
        3338931491335474853,
        1208524028640747044,
        4348430812640332576,
        5466003927213953856,
        9108318248782395817,
        1054788689439567683,
        4655366844777873613,
        4928795777763026387,
        2382857281937512148,
        5326154727497491296,
        6749950087419718546,
        6005311415062353381,
        3755267398465561910,
        8692242226329793753,
        8224230343177812709,
        6120771184520365789,
        2145057547654837063,
        359278190594841043,
        5573673931201771828,
        257676148270901083,
        3870601863619026574,
        8442841799072723783,
        5815623326753790111,
        470549825933408633,
        1118764966067220,
        3003377829947421413
      ],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    UserStory: EntityDefinition<UserStory>(
        model: _entities[0],
        toOneRelations: (UserStory object) => [],
        toManyRelations: (UserStory object) => {},
        getId: (UserStory object) => object.storyId,
        setId: (UserStory object, int id) {
          object.storyId = id;
        },
        objectToFB: (UserStory object, fb.Builder fbb) {
          final sImageOffset = fbb.writeString(object.sImage);
          final sUserImageOffset = fbb.writeString(object.sUserImage);
          final sUserNameOffset = fbb.writeString(object.sUserName);
          fbb.startTable(5);
          fbb.addInt64(0, object.storyId);
          fbb.addOffset(1, sImageOffset);
          fbb.addOffset(2, sUserImageOffset);
          fbb.addOffset(3, sUserNameOffset);
          fbb.finish(fbb.endTable());
          return object.storyId;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = UserStory(
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''),
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 10, ''),
              storyId:
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0));

          return object;
        }),
    User: EntityDefinition<User>(
        model: _entities[1],
        toOneRelations: (User object) => [],
        toManyRelations: (User object) => {},
        getId: (User object) => object.id,
        setId: (User object, int id) {
          object.id = id;
        },
        objectToFB: (User object, fb.Builder fbb) {
          final userIdOffset =
              object.userId == null ? null : fbb.writeString(object.userId!);
          final firstNameOffset = object.firstName == null
              ? null
              : fbb.writeString(object.firstName!);
          final lastNameOffset = object.lastName == null
              ? null
              : fbb.writeString(object.lastName!);
          final dateOfBirthOffset = object.dateOfBirth == null
              ? null
              : fbb.writeString(object.dateOfBirth!);
          final phoneNumberOffset = object.phoneNumber == null
              ? null
              : fbb.writeString(object.phoneNumber!);
          final imageOffset =
              object.image == null ? null : fbb.writeString(object.image!);
          final emailOffset =
              object.email == null ? null : fbb.writeString(object.email!);
          final passwordOffset = object.password == null
              ? null
              : fbb.writeString(object.password!);
          final interestsOffset = object.interests == null
              ? null
              : fbb.writeString(object.interests!);
          fbb.startTable(11);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, userIdOffset);
          fbb.addOffset(2, firstNameOffset);
          fbb.addOffset(3, lastNameOffset);
          fbb.addOffset(4, dateOfBirthOffset);
          fbb.addOffset(5, phoneNumberOffset);
          fbb.addOffset(6, imageOffset);
          fbb.addOffset(7, emailOffset);
          fbb.addOffset(8, passwordOffset);
          fbb.addOffset(9, interestsOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = User(
              userId: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              firstName: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8),
              lastName: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 10),
              dateOfBirth: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 12),
              phoneNumber: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 14),
              interests: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 22),
              image: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 16),
              email: const fb.StringReader(asciiOptimization: true).vTableGetNullable(buffer, rootOffset, 18),
              password: const fb.StringReader(asciiOptimization: true).vTableGetNullable(buffer, rootOffset, 20),
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0));

          return object;
        }),
    UserPost: EntityDefinition<UserPost>(
        model: _entities[2],
        toOneRelations: (UserPost object) => [],
        toManyRelations: (UserPost object) => {},
        getId: (UserPost object) => object.pid,
        setId: (UserPost object, int id) {
          object.pid = id;
        },
        objectToFB: (UserPost object, fb.Builder fbb) {
          final postIdOffset =
              object.postId == null ? null : fbb.writeString(object.postId!);
          final postTimeOffset = object.postTime == null
              ? null
              : fbb.writeString(object.postTime!);
          final descriptionOffset = object.description == null
              ? null
              : fbb.writeString(object.description!);
          final imageOffset =
              object.image == null ? null : fbb.writeString(object.image!);
          final titleOffset =
              object.title == null ? null : fbb.writeString(object.title!);
          fbb.startTable(11);
          fbb.addOffset(0, postIdOffset);
          fbb.addOffset(1, postTimeOffset);
          fbb.addOffset(2, descriptionOffset);
          fbb.addOffset(3, imageOffset);
          fbb.addInt64(8, object.pid);
          fbb.addOffset(9, titleOffset);
          fbb.finish(fbb.endTable());
          return object.pid;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = UserPost(
              postId: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 4),
              postTime: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              title: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 22),
              description: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8),
              image: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 10),
              pid: const fb.Int64Reader().vTableGet(buffer, rootOffset, 20, 0));

          return object;
        }),
    Groups: EntityDefinition<Groups>(
        model: _entities[3],
        toOneRelations: (Groups object) => [],
        toManyRelations: (Groups object) => {},
        getId: (Groups object) => object.id,
        setId: (Groups object, int id) {
          object.id = id;
        },
        objectToFB: (Groups object, fb.Builder fbb) {
          final groupIdOffset =
              object.groupId == null ? null : fbb.writeString(object.groupId!);
          final groupNameOffset = object.groupName == null
              ? null
              : fbb.writeString(object.groupName!);
          fbb.startTable(7);
          fbb.addOffset(1, groupIdOffset);
          fbb.addOffset(2, groupNameOffset);
          fbb.addInt64(5, object.id);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Groups(
              groupId: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              groupName: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8),
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 14, 0));

          return object;
        }),
    Comment: EntityDefinition<Comment>(
        model: _entities[4],
        toOneRelations: (Comment object) => [object.user, object.post],
        toManyRelations: (Comment object) => {},
        getId: (Comment object) => object.cid,
        setId: (Comment object, int id) {
          object.cid = id;
        },
        objectToFB: (Comment object, fb.Builder fbb) {
          final commentIdOffset = object.commentId == null
              ? null
              : fbb.writeString(object.commentId!);
          final contentOffset =
              object.content == null ? null : fbb.writeString(object.content!);
          fbb.startTable(6);
          fbb.addInt64(0, object.cid);
          fbb.addOffset(1, commentIdOffset);
          fbb.addInt64(2, object.user.targetId);
          fbb.addInt64(3, object.post.targetId);
          fbb.addOffset(4, contentOffset);
          fbb.finish(fbb.endTable());
          return object.cid;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Comment(
              commentId: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              content: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 12),
              cid: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0));
          object.user.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0);
          object.user.attach(store);
          object.post.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0);
          object.post.attach(store);
          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [UserStory] entity fields to define ObjectBox queries.
class UserStory_ {
  /// see [UserStory.storyId]
  static final storyId =
      QueryIntegerProperty<UserStory>(_entities[0].properties[0]);

  /// see [UserStory.sImage]
  static final sImage =
      QueryStringProperty<UserStory>(_entities[0].properties[1]);

  /// see [UserStory.sUserImage]
  static final sUserImage =
      QueryStringProperty<UserStory>(_entities[0].properties[2]);

  /// see [UserStory.sUserName]
  static final sUserName =
      QueryStringProperty<UserStory>(_entities[0].properties[3]);
}

/// [User] entity fields to define ObjectBox queries.
class User_ {
  /// see [User.id]
  static final id = QueryIntegerProperty<User>(_entities[1].properties[0]);

  /// see [User.userId]
  static final userId = QueryStringProperty<User>(_entities[1].properties[1]);

  /// see [User.firstName]
  static final firstName =
      QueryStringProperty<User>(_entities[1].properties[2]);

  /// see [User.lastName]
  static final lastName = QueryStringProperty<User>(_entities[1].properties[3]);

  /// see [User.dateOfBirth]
  static final dateOfBirth =
      QueryStringProperty<User>(_entities[1].properties[4]);

  /// see [User.phoneNumber]
  static final phoneNumber =
      QueryStringProperty<User>(_entities[1].properties[5]);

  /// see [User.image]
  static final image = QueryStringProperty<User>(_entities[1].properties[6]);

  /// see [User.email]
  static final email = QueryStringProperty<User>(_entities[1].properties[7]);

  /// see [User.password]
  static final password = QueryStringProperty<User>(_entities[1].properties[8]);

  /// see [User.interests]
  static final interests =
      QueryStringProperty<User>(_entities[1].properties[9]);
}

/// [UserPost] entity fields to define ObjectBox queries.
class UserPost_ {
  /// see [UserPost.postId]
  static final postId =
      QueryStringProperty<UserPost>(_entities[2].properties[0]);

  /// see [UserPost.postTime]
  static final postTime =
      QueryStringProperty<UserPost>(_entities[2].properties[1]);

  /// see [UserPost.description]
  static final description =
      QueryStringProperty<UserPost>(_entities[2].properties[2]);

  /// see [UserPost.image]
  static final image =
      QueryStringProperty<UserPost>(_entities[2].properties[3]);

  /// see [UserPost.pid]
  static final pid = QueryIntegerProperty<UserPost>(_entities[2].properties[4]);

  /// see [UserPost.title]
  static final title =
      QueryStringProperty<UserPost>(_entities[2].properties[5]);
}

/// [Groups] entity fields to define ObjectBox queries.
class Groups_ {
  /// see [Groups.groupId]
  static final groupId =
      QueryStringProperty<Groups>(_entities[3].properties[0]);

  /// see [Groups.groupName]
  static final groupName =
      QueryStringProperty<Groups>(_entities[3].properties[1]);

  /// see [Groups.id]
  static final id = QueryIntegerProperty<Groups>(_entities[3].properties[2]);
}

/// [Comment] entity fields to define ObjectBox queries.
class Comment_ {
  /// see [Comment.cid]
  static final cid = QueryIntegerProperty<Comment>(_entities[4].properties[0]);

  /// see [Comment.commentId]
  static final commentId =
      QueryStringProperty<Comment>(_entities[4].properties[1]);

  /// see [Comment.user]
  static final user =
      QueryRelationToOne<Comment, User>(_entities[4].properties[2]);

  /// see [Comment.post]
  static final post =
      QueryRelationToOne<Comment, UserPost>(_entities[4].properties[3]);

  /// see [Comment.content]
  static final content =
      QueryStringProperty<Comment>(_entities[4].properties[4]);
}
