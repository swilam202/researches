import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    checkAndRequestPermissions();

    super.initState();
  }

  Future<void> checkAndRequestPermissions() async {
    final OnAudioQuery query = OnAudioQuery();
    await query.checkAndRequest();
  }

  Future<List<SongModel>> queryAudio() async {
    final OnAudioQuery query = OnAudioQuery();
    return await query.querySongs();
  }

  Future<List<String>> queryAllPath() async {
    final OnAudioQuery query = OnAudioQuery();
    return await query.queryAllPath();
  }

  Future<List<AlbumModel>> queryAlbums() async {
    final OnAudioQuery query = OnAudioQuery();
    return await query.queryAlbums();
  }

  Future<List<ArtistModel>> queryArtists() async {
    final OnAudioQuery query = OnAudioQuery();
    return await query.queryArtists();
  }

  Future<List<PlaylistModel>> queryPlaylists() async {
    final OnAudioQuery query = OnAudioQuery();
    return await query.queryPlaylists();
  }

  Future<void> createPlaylist(String playlistName, {String? author}) async {
    final OnAudioQuery query = OnAudioQuery();
    await query.createPlaylist(playlistName, author: author);
  }

  Future<void> addToPlaylist(int playlistId, int audioId) async {
    final OnAudioQuery query = OnAudioQuery();
    await query.addToPlaylist(playlistId, audioId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('On Audio Query Example')),

        body: Center(
          child: FutureBuilder(
            future: queryAudio(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) =>
                      show(snapshot.data![index].id, ArtworkType.AUDIO),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

Widget show(audioId, ArtworkType type) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: QueryArtworkWidget(id: audioId, type: type),
  );
}


///Permissions
///<manifest>
//
//   <!-- Android 12 or below  -->
//   <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
//   <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
//
//   <!-- Android 13 or greater  -->
//   <uses-permission android:name="android.permission.READ_MEDIA_IMAGES"/>
//   <uses-permission android:name="android.permission.READ_MEDIA_VIDEO"/>
//   <uses-permission android:name="android.permission.READ_MEDIA_AUDIO"/>
//
// </manifest>

///<dict>
//
// 	<key>NSAppleMusicUsageDescription</key>
// 	<string>$(PROJECT_NAME) requires access to media library</string>
//
// </dict>