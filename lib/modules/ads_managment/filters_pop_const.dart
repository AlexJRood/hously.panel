import 'package:get/get.dart';

class FilterPopConst{
  static const List<String> typeOfBuildingOptions = [
    'Apartment',
    'Villa',
    'Townhouse',
    'Duplex',
  ];
  static const List<String> buildingMaterialOptions = [
    'Concrete',
    'Brick',
    'Wood',
    'Steel',
  ];
  static const List<String> heatingTypeOptions = [
    'Gas',
    'Electric',
    'Solar',
    'None',
  ];
  static const List<String> advertiserOptions = [
    'Agent',
    'Developer',
    'Private Owner',
  ];
  static  List<Map<String, String>> additionalInfo = [
    {'text': 'Balkon'.tr, 'filterKey': 'balcony'},
    {'text': 'Taras'.tr, 'filterKey': 'terrace'},
    {'text': 'Piwnica'.tr, 'filterKey': 'basement'},
    {'text': 'Winda'.tr, 'filterKey': 'elevator'},
    {'text': 'Ogród'.tr, 'filterKey': 'garden'},
    {'text': 'Klimatyzacja'.tr, 'filterKey': 'air_conditioning'},
    {'text': 'Garaż'.tr, 'filterKey': 'garage'},
    {'text': 'Miejsce postojowe'.tr, 'filterKey': 'parking_space'},
    {'text': 'Jacuzzi', 'filterKey': 'jacuzzi'},
    {'text': 'Sauna', 'filterKey': 'sauna'},
  ];
  static const List<Map<String, String>> estateTypes = [
    {'text': 'Mieszkanie', 'filterValue': 'Flat'},
    {'text': 'Kawalerka', 'filterValue': 'Studio'},
    {'text': 'Apartament', 'filterValue': 'Apartment'},
    {'text': 'Dom jednorodzinny', 'filterValue': 'House'},
    {'text': 'Bliźniak', 'filterValue': 'Twin house'},
    {'text': 'Szeregowiec', 'filterValue': 'Row house'},
    {'text': 'Inwestycje', 'filterValue': 'Invest'},
    {'text': 'Działki', 'filterValue': 'Lot'},
    {'text': 'Lokale użytkowe', 'filterValue': 'Commercial'},
    {'text': 'Hale i magazyny', 'filterValue': 'Warehouse'},
    {'text': 'Pokoje', 'filterValue': 'Room'},
    {'text': 'Garaże', 'filterValue': 'Garage'},
  ];

}