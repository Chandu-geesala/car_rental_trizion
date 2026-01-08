import '../models/car.dart';

class MockData {
  static List<Car> getCars() {
    return [
      Car(
        id: '1',
        name: 'AMG GT S',
        brand: 'Mercedes-Benz',
        imageUrl: 'https://images.unsplash.com/photo-1605559424843-9e4c228bf1c2?w=400',
        pricePerDay: 15000,
        seats: 2,
        transmission: 'Automatic',
        fuelType: 'Petrol',
        rating: 4.9,
        isAvailable: true,
      ),

      Car(
        id: '2',
        name: 'Creta',
        brand: 'Hyundai',
        imageUrl: 'https://images.unsplash.com/photo-1619767886558-efdc259cde1a?w=400',
        pricePerDay: 2500,
        transmission: 'Automatic',
        seats: 5,
        fuelType: 'Diesel',
        isAvailable: false,
        rating: 4.7,
      ),
      Car(
        id: '3',
        name: 'Fortuner',
        brand: 'Toyota',
        imageUrl: 'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?w=400',
        pricePerDay: 5000,
        transmission: 'Automatic',
        seats: 7,
        fuelType: 'Diesel',
        isAvailable: true,
        rating: 4.8,
      ),
      Car(
        id: '4',
        name: 'Camaro SS',
        brand: 'Chevrolet',
        imageUrl: 'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?w=400',
        pricePerDay: 8500,
        seats: 4,
        transmission: 'Automatic',
        fuelType: 'Petrol',
        rating: 4.7,
        isAvailable: true,
      ),

      Car(
        id: '5',
        name: 'M4 Coupe',
        brand: 'BMW',
        imageUrl: 'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=400',
        pricePerDay: 12000,
        seats: 4,
        transmission: 'Automatic',
        fuelType: 'Petrol',
        rating: 4.8,
        isAvailable: true,
      ),


    ];
  }
}
