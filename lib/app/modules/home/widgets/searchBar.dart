import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:youtube/app/modules/home/repository/data.dart';

class SearchBarWidget extends StatelessWidget {
  final void Function(String) searchFunction;
  final QueryService queryService;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController queryController;
  final SuggestionsBoxController suggestionsBoxController;

  SearchBarWidget(
      {Key key,
      this.searchFunction,
      this.queryService,
      this.queryController,
      this.suggestionsBoxController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TypeAheadFormField(
                debounceDuration: Duration(milliseconds: 300),
                suggestionsBoxController: suggestionsBoxController,
                loadingBuilder: (context) => CircularProgressIndicator(),
                hideOnEmpty: true,
                hideOnLoading: true,
                textFieldConfiguration: TextFieldConfiguration(
                  controller: queryController,
                  autofocus: true,
                  onSubmitted: (value) => searchFunction(value),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () => queryController.clear(),
                      ),
                      border: OutlineInputBorder(),
                      hintText: 'Digite o que procura'),
                ),
                suggestionsCallback: queryService.getSuggestions,
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text('$suggestion'),
                  );
                },
                onSuggestionSelected: searchFunction,
                validator: (value) {
                  if (value.isEmpty) {
                    return '';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
