abstract class IRentalItemRepository{
  Future save();
  Future update();
  Future getById();
  Future getAll();  
}

class RentalItemRepository implements IRentalItemRepository {
  @override
  Future getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future getById() {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future save() {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  Future update() {
    // TODO: implement update
    throw UnimplementedError();
  }

}