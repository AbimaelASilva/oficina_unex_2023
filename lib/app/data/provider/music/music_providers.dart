import 'package:dio/dio.dart';
import '../../models/models.dart';

class MusicProviders {
  MusicProviders();
  final dio = Dio();

  Future<List<MusicMagnataModel>> getMusicList() async {
    final response =
        await dio.get('https://portaldocultioapi.azurewebsites.net/api/music');
    print("MAGANATA: ${response.data.toString()}");
    // The below request is the same as above.

    return <Map<String, dynamic>>[...response.data ?? []]
        .map((music) => MusicMagnataModel.fromMap(music))
        .toList();
  }
  // final ProDioConnect _proDioConnect;

  // Future<List<PetModel>> getLostPets() async {
  //   try {
  //     final response = await _proDioConnect.get(
  //       url: UrlsApp.urlApiNodeVercel,
  //       ep: '/pets',
  //     );

  //     return <Map<String, dynamic>>[...response['posts'] ?? []]
  //         .map(PetModel.fromMap)
  //         .toList();
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
