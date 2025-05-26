import 'package:flutter/material.dart';
import 'package:spotify/spotify.dart' hide Image;
import 'package:testyfy/ui/core/ui/animated_text_overflow.dart';
import 'package:testyfy/utils/localization_utils.dart';

class ArtistDisplayWidget extends StatelessWidget {
  final Artist artist;

  const ArtistDisplayWidget({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.all(Radius.circular(20)),
        child: Container(
          color: Theme.of(context).highlightColor,
          constraints: BoxConstraints(maxHeight: 120),
          child: Row(
            children: [
              SizedBox(width: 16),
              Container(
                constraints: BoxConstraints(maxWidth: 75, maxHeight: 75),
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.all(Radius.circular(5)),
                    child: Image.network(artist.images!.last.url!, fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(context.localizations.searchResultArtist),
                    AnimatedTextOverFlow(child: Text(artist.name!, maxLines: 1, style: TextStyle(fontSize: 24))),
                  ],
                ),
              ),
              SizedBox(width: 16),
            ],
          ),
        ),
      ),
    );
  }
}
