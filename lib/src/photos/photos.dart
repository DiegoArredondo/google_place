import 'dart:typed_data';

import 'package:google_place/src/photos/photo_parameters.dart';
import 'package:google_place/src/utils/network_utility.dart';

class Photos {
  final _authority = 'maps.googleapis.com';
  final _unencodedPath = 'maps/api/place/photo';
  final String apiKEY;

  Photos(this.apiKEY);

  /// The Place Photo service, part of the Places API, is a read- only API that allows you to
  /// add high quality photographic content to your application. The Place Photo service gives
  /// you access to the millions of photos stored in the Places database. When you get place
  /// information using a Place Details request, photo references will be returned for relevant
  /// photographic content. Find Place, Nearby Search, and Text Search requests also return a
  /// single photo reference per place, when relevant. Using the Photo service you can then access
  /// the referenced photos and resize the image to the optimal size for your application.
  ///
  /// [photoReference] Required parameters - A string identifier that uniquely identifies a photo.
  /// Photo references are returned from either a Place Search or Place Details request.
  ///
  /// [minprice] or [maxprice] Required parameters - Specifies the maximum desired height or width,
  /// in pixels, of the image returned by the Place Photos service. If the image is smaller than
  /// the values specified, the original image will be returned. If the image is larger in either
  /// dimension, it will be scaled to match the smaller of the two dimensions, restricted to its
  /// original aspect ratio. Both the maxheight and maxwidth properties accept an integer
  /// between 1 and 1600.
  Future<Uint8List> get(
    String photoReference,
    int maxHeight,
    int maxWidth,
  ) async {
    assert(photoReference != null);
    assert(photoReference != "");
    assert(maxHeight != null || maxWidth != null);
    var queryParameters = PhotoParameters.createParameters(
      apiKEY,
      photoReference,
      maxHeight,
      maxWidth,
    );
    var uri = Uri.https(_authority, _unencodedPath, queryParameters);
    var response = await NetworkUtility.fetchUrl(uri);
    if (response != null) {
      List<int> list = response.codeUnits;
      return Uint8List.fromList(list);
    }
    return null;
  }
}
