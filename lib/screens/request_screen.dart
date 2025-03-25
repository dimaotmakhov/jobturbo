import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:jobturbo/models/Request.dart';
import 'package:jobturbo/utils/countries.dart';
import '../l10n/app_localizations.dart';
import 'dart:convert';

class RequestScreen extends StatefulWidget {
  final Future<GraphQLResponse<String>> Function()? mockQueryProvider;

  const RequestScreen({super.key, this.mockQueryProvider});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _locationController = TextEditingController();
  final _positionController = TextEditingController();
  final _keywordsController = TextEditingController();
  Country? _selectedCountry;
  bool _isLoading = true;

  List<Request> _requests = [];


  @override
  void initState() {
    super.initState();
    _refreshRequests();
  }

  String listRequestsByDateQuery = '''
query ListByDate(
  \$createdAt: ModelStringKeyConditionInput
  \$filter: ModelRequestFilterInput
  \$limit: Int
  \$nextToken: String
  \$owner: String!
  \$sortDirection: ModelSortDirection
) {
  listRequestByOwnerAndCreatedAt(
    createdAt:\$createdAt
    filter: \$filter
    limit: \$limit
    nextToken: \$nextToken
    owner: \$owner
    sortDirection: \$sortDirection
  ) {
    items {
      createdAt
      id
      country
      location
      position
      keywords
      repeat
      updatedAt
      __typename
    }
    nextToken
    __typename
  }
}
''';

  Future<void> _refreshRequests() async {

    final result = await Amplify.Auth.fetchAuthSession();
    String owner = result.toJson()['userSub'] as String;

    try {
      final request = GraphQLRequest<String>(document: listRequestsByDateQuery, variables: {
        'limit': 1000,
        'sortDirection': 'DESC',
        'owner': '$owner::$owner',
      });

      final response = widget.mockQueryProvider != null
          ? await widget.mockQueryProvider!()
          : await Amplify.API.query(request: request).response;

      Map<String, dynamic> jsonMap = json.decode(response.data!);

      final requestsJson =
          jsonMap['listRequestByOwnerAndCreatedAt']['items'] as List<dynamic>;

      if (response.hasErrors) {
        safePrint('errors: ${response.errors}');
        return;
      }

      setState(() {
        _requests = requestsJson.map((item) => Request.fromJson(item)).toList();
        _isLoading = false;
      });
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteRequest(Request request) async {
    try {
      final deleteRequest = ModelMutations.delete(request);
      final response =
          await Amplify.API.mutate(request: deleteRequest).response;

      if (response.hasErrors) {
        safePrint('Deleting Request failed: ${response.errors}');
      } else {
        safePrint('Deleting Request successful');
        _refreshRequests();
      }
    } on ApiException catch (e) {
      safePrint('Delete mutation failed: $e');
    }
  }

  void _showAddRequestDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final localizations = AppLocalizations.of(context)!;
        final theme = Theme.of(context);
        final isDark = theme.brightness == Brightness.dark;

        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text(localizations.addNewRequest),
            content: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<Country>(
                      value: _selectedCountry,
                      decoration: InputDecoration(
                        labelText: localizations.country,
                      ),
                      hint: Text(localizations.selectCountry),
                      items: countries.map((Country country) {
                        return DropdownMenuItem<Country>(
                          value: country,
                          child: Text(country.name),
                        );
                      }).toList(),
                      onChanged: (Country? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedCountry = newValue;
                          });
                        }
                      },
                      validator: (value) {
                        if (value == null) {
                          return localizations.pleaseSelectCountry;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        labelText: localizations.location,
                        hintText: localizations.enterLocation,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return localizations.pleaseEnterLocation;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _positionController,
                      decoration: InputDecoration(
                        labelText: localizations.position,
                        hintText: localizations.enterPosition,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return localizations.pleaseEnterPosition;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _keywordsController,
                      decoration: InputDecoration(
                        labelText: localizations.keywords,
                        hintText: localizations.enterKeywordsSeparated,
                      ),
                    ),
                    const SizedBox(height: 16),

                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(localizations.cancel),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {

                    final newRequest = Request(
                      createdAt: TemporalDateTime.now(),
                      updatedAt: TemporalDateTime.now(),
                      sortKey: "sortKey",
                      country: _selectedCountry!.code,
                      location: _locationController.text,
                      position: _positionController.text,
                      keywords: _keywordsController.text
                          .split(',')
                          .map((e) => e.trim())
                          .where((e) => e.isNotEmpty)
                          .toList(),
                    );
                    final request = ModelMutations.create(newRequest);
                    final response =
                        await Amplify.API.mutate(request: request).response;
                    if (response.hasErrors) {
                      safePrint('Creating Request failed.');
                    } else {
                      _refreshRequests();
                      safePrint('Creating Request successful.');
                    }
                    _locationController.clear();
                    _positionController.clear();
                    _keywordsController.clear();
                    Navigator.pop(context);
                  }
                },
                child: Text(localizations.create),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _locationController.dispose();
    _positionController.dispose();
    _keywordsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _requests.isEmpty
              ? Center(
                  child: Text(localizations.noRequests),
                )
              : ListView.builder(
                  itemCount: _requests.length,
                  itemBuilder: (context, index) {
                    final request = _requests[index];
                    final country = countries.firstWhere(
                      (c) => c.code == request.country,
                      orElse: () => Country('Unknown', ''),
                    );
                    return Dismissible(
                      key: Key(request.id ?? ''),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20.0),
                        color: theme.colorScheme.error,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      onDismissed: (direction) {
                        _deleteRequest(request);
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(
                          title: Text(request.position ?? ''),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(localizations.countryLabel(country.name)),
                              Text(localizations
                                  .locationLabel(request.location ?? '')),
                              Text(localizations.keywordsLabel(
                                  request.keywords?.join(", ") ?? '')),
                            ],
                          ),
                          isThreeLine: true,
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddRequestDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
