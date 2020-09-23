part of flutter_widget_model;

/// Data model with a data structure for collections.
/// 
/// The contents of the collection store data documents and so on, including data that sequentially reads the stored data list as it is stored.
/// 
/// Executing the [save] method saves the data in the device.
/// Even if the application is terminated, the data will be restored and available.
/// 
/// ```
/// 
/// Widget build(BuildContext context) {
///   return Scaffold(
///     appBar: AppBar(
///       title: Text("Title"),
///     ),
///     body: ListView(
///       children: LocalCollectionModel("user").map(
///         (item) => ListTile(
///           title: Text(
///             item.getString("uid")
///           ),
///         ),
///       ),
///     ),
///     floatingActionButton: FloatingActionButton(
///       onPressed: () {
///         LocalCollectionModel("user").append(
///           Texts.uuid,
///           builder: (doc) {
///             doc["uid"] = Texts.uuid;
///           },
///         );
///       },
///       child: Icon(Icons.add),
///     ),
///   );
/// }
/// ```
class LocalCollectionModel extends CollectionModel<LocalCollection> {
  final List<Map<String, dynamic>> data;
  
  /// Data model with a data structure for collections.
  /// 
  /// The contents of the collection store data documents and so on, including data that sequentially reads the stored data list as it is stored.
  /// 
  /// Executing the [save] method saves the data in the device.
  /// Even if the application is terminated, the data will be restored and available.
  /// 
  /// Defines the data document of the specified [path].
  LocalCollectionModel(String path, [this.data]) : super(path);
  @override
  FutureOr<LocalCollection> build(ModelContext context) {
    return LocalCollection.load(this.path);
  }

  /// Add a new document to the collection.
  /// 
  /// Documents added to the collection are stored in the path specified by [id] (or UUID).
  /// 
  /// You can define the initial values of a document by specifying [data] and edit the internal data with the [builder].
  Future append(
      {String id,
      Map<String, dynamic> data,
      FutureOr builder(LocalDocument document)}) async {
    String path = Paths.child(this.path, id ?? Texts.uuid);
    LocalDocument state = LocalDocument(path);
    if (data != null) {
      for (MapEntry<String, dynamic> tmp in data.entries) {
        if (isEmpty(tmp.key) || tmp.value == null) continue;
        state[tmp.key] = tmp.value;
      }
    }
    if (builder != null) await builder(state);
    await state.save();
  }
}