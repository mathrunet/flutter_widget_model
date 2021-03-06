part of flutter_widget_model;

/// Model for storing data in Key-Value-Pair document format on runtime.
///
/// ```
/// Widget build(BuildContext context) {
///   return Scaffold(
///     appBar: AppBar(
///       title: Text("Title"),
///     ),
///     body: ListView(
///       children: [
///         ListTile(
///           title: Text("Name: ${DataDocumentModel("user")["name"]}")
///         ),
///         ListTile(
///           title: Text("Age: ${DataDocumentModel("user")["age"]}")
///         ),
///         ListTile(
///           title: Text("Country: ${DataDocumentModel("user")["country"]}")
///         )
///       ]
///     )
///     floatingActionButton: FloatingActionButton(
///       onPressed: () {
///         DataDocumentModel("user").save(
///           data: {
///             "name": "Username",
///             "age": 18,
///             "address": "Japan"
///           }
///         );
///       },
///       child: Icon(Icons.add),
///     ),
///   );
/// }
/// ```
class RuntimeDocumentModel extends DocumentModel<RuntimeDocument> {
  /// Value to be set in the data document.
  final Map<String, dynamic> _data;

  /// Model for storing data in Key-Value-Pair document format on runtime.
  ///
  /// Defines the data document of the specified [path].
  ///
  /// If [data] is specified, [data] will be set to the specified [path].
  RuntimeDocumentModel(String path, {Map<String, dynamic> data})
      : this._data = data,
        super(path);
  @override
  RuntimeDocument build(ModelContext context) {
    if (this._data == null) return RuntimeDocument(this.path);
    return RuntimeDocument.fromMap(this.path, this._data);
  }
}
