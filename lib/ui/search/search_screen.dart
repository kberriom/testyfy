import 'package:flutter/material.dart' hide Page;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify/spotify.dart';
import 'package:testyfy/ui/core/ui/Track_display_widget.dart';
import 'package:testyfy/ui/core/ui/album_display_widget.dart';
import 'package:testyfy/ui/core/ui/artist_display_widget.dart';
import 'package:testyfy/ui/core/ui/generic_error_widget.dart';
import 'package:testyfy/ui/core/ui/generic_no_data_widget.dart';
import 'package:testyfy/ui/search/no_search_widget.dart';
import 'package:testyfy/ui/search/view_model/search_viewmodel.dart';
import 'package:testyfy/utils/localization_utils.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late final TextEditingController _searchTextController;
  bool _hasSearched = false;
  int _searchRequestKeyStrokeNumber = 0;

  bool _filterByTrack = true;
  bool _filterByArtist = false;
  bool _filterByAlbum = false;

  @override
  void initState() {
    _searchTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Column(
          children: [
            SearchBar(
              elevation: WidgetStatePropertyAll(0),
              trailing: [Icon(Icons.search)],
              hintText: context.localizations.searchBarHintHome,
              onChanged: (value) async {
                int thisRequestNumber = (_searchRequestKeyStrokeNumber += 1);
                await Future.delayed(const Duration(milliseconds: 450));
                if ((thisRequestNumber == _searchRequestKeyStrokeNumber) && mounted) {
                  _searchTextController.text = value;
                  setState(() {
                    _hasSearched = value.isNotEmpty;
                  });
                }
              },
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilterChip(
                  label: Text(context.localizations.searchResultTrack),
                  showCheckmark: _filterByTrack,
                  selected: _filterByTrack,
                  onSelected: (bool value) {
                    setState(() {
                      if (_filterByArtist || _filterByAlbum) {
                        _filterByTrack = !_filterByTrack;
                      }
                    });
                  },
                ),
                SizedBox(width: 8),
                FilterChip(
                  label: Text(context.localizations.searchResultArtist),
                  showCheckmark: _filterByArtist,
                  selected: _filterByArtist,
                  onSelected: (bool value) {
                    setState(() {
                      if (_filterByAlbum || _filterByTrack) {
                        _filterByArtist = !_filterByArtist;
                      }
                    });
                  },
                ),
                SizedBox(width: 8),
                FilterChip(
                  label: Text(context.localizations.searchResultAlbum),
                  showCheckmark: _filterByAlbum,
                  selected: _filterByAlbum,
                  onSelected: (bool value) {
                    setState(() {
                      if (_filterByTrack || _filterByArtist) {
                        _filterByAlbum = !_filterByAlbum;
                      }
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            if (!_hasSearched) Flexible(child: const NoSearchWidget()),
            if (_hasSearched)
              Flexible(
                child: SearchResultWidget(
                  key: ValueKey(_searchTextController.text),
                  searchTerm: _searchTextController.text,
                  searchTypes: [
                    if (_filterByTrack) SearchType.track,
                    if (_filterByArtist) SearchType.artist,
                    if (_filterByAlbum) SearchType.album,
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class SearchResultWidget extends ConsumerWidget {
  final String searchTerm;
  final List<SearchType> searchTypes;

  const SearchResultWidget({super.key, required this.searchTerm, required this.searchTypes});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Page>> resultList = ref.watch(searchResultViewmodelProvider.call(searchTerm, searchTypes));

    return RefreshIndicator(
      onRefresh: () => ref.refresh(searchResultViewmodelProvider.call(searchTerm, searchTypes).future),
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
        child: resultList.when(
          data: (pages) {
            List<Page> rawResultList = pages.toList();
            if (rawResultList.isEmpty) {
              return const GenericNoDataWidget();
            }
            List<dynamic> extractedResultList = [];
            for (var listType in rawResultList) {
              extractedResultList.addAll(listType.items!.toList());
            }
            extractedResultList.shuffle();
            if (extractedResultList.isEmpty) {
              return const GenericNoDataWidget();
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                if (index <= extractedResultList.length - 1) {
                  switch (extractedResultList[index]) {
                    case Track():
                      return TrackDisplayWidget(track: extractedResultList[index] as Track);
                    case Artist():
                      return ArtistDisplayWidget(artist: extractedResultList[index] as Artist);
                    case AlbumSimple():
                      return AlbumDisplayWidget(album: extractedResultList[index] as AlbumSimple);
                    case _:
                      return const Center(child: Icon(Icons.error));
                  }
                }
                return null;
              },
              padding: EdgeInsetsGeometry.only(top: 16),
            );
          },
          error: (error, stackTrace) => const GenericErrorWidget(),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
