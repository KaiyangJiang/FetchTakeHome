import Foundation

class DataManager {
    private let mealDetailCache = LRUCache<String, MealDetail>(capacity: 10)

    // Singleton instance
    static let shared = DataManager()

    func fetchMeals() async throws -> [Meal] {
        let urlString = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        do {
            let meals = try await NetworkService.shared.fetchRecipe(url: urlString)
            let sortedMeals = meals.sorted { $0.strMeal < $1.strMeal }
            return sortedMeals
        } catch {
            throw error
        }
    }

    func fetchMealDetail(id: String) async throws -> MealDetail? {
        // Cache hit
        if let cachedMealDetail = mealDetailCache.get(id) {
            print("Returning cached meal detail for id: \(id)")
            return cachedMealDetail
        }

        let urlString = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
        
        // Cache miss
        do {
            let mealDetail = try await NetworkService.shared.fetchRecipeDetail(url: urlString)
            
            // Store the fetched meal detail in the cache
            if let mealDetail = mealDetail {
                mealDetailCache.set(id, value: mealDetail)
                print("Meal detail for id \(id) cached")
            }

            return mealDetail
        } catch {
            throw error
        }
    }
}


class LRUCache<Key:Hashable, Value>{
    
    private let capacity:Int
    private var cache:[Key:Value] = [:]
    private var order:[Key] = []
    
    init(capacity: Int) {
        self.capacity = capacity
    }
    
    func get(_ key:Key) -> Value?{
        guard let value = cache[key] else{
            print("cache miss")
            return nil
        }
        
        if let index = order.firstIndex(of: key){
            order.remove(at: index)
            order.append(key)
        }
        print("cache hit order list: \(order)")
        return value
    }
    
    func set(_ key:Key, value:Value) {
        if capacity <= cache.count{
            let leastUsedKey = order.removeFirst()
            cache.removeValue(forKey: leastUsedKey)
        }
        
        if let index = order.firstIndex(of: key){
            order.remove(at: index)
        }
        order.append(key)
        cache[key] = value
        print("cache set key: \(key) count:\(cache.count)")
        
    }
    
}
