data = angular.module("food-data", [])


# Provides food data and related state from data/nutrients.csv and data/foods.csv
data.factory "FoodData", ($rootScope, Styles) ->

  allFoods = null

  allKeys = [
    "NDB_No", "Long_Desc", "FdGrp_Desc", "10:0", "12:0", "13:0", "14:0", "14:1", "15:0",
    "15:1", "16:0", "16:1 c", "16:1 t", "16:1 undifferentiated", "17:0", "17:1", "18:0",
    "18:1 c", "18:1 t", "18:1 undifferentiated", "18:1-11t (18:1t n-7)", "18:2 CLAs",
    "18:2 i", "18:2 n-6 c,c", "18:2 t not further defined", "18:2 t,t", "18:2 undifferentiated",
    "18:3 n-3 c,c,c (ALA)", "18:3 n-6 c,c,c", "18:3 undifferentiated", "18:3i", "18:4", "20:0",
    "20:1", "20:2 n-6 c,c", "20:3 n-3", "20:3 n-6", "20:3 undifferentiated", "20:4 n-6",
    "20:4 undifferentiated", "20:5 n-3 (EPA)", "21:5", "22:0", "22:1 c", "22:1 t",
    "22:1 undifferentiated", "22:4", "22:5 n-3 (DPA)", "22:6 n-3 (DHA)", "24:0", "24:1 c",
    "4:0", "6:0", "8:0", "Adjusted Protein", "Alanine", "Alcohol, ethyl", "Arginine", "Ash",
    "Aspartic acid", "Betaine", "Beta-sitosterol", "Caffeine", "Calcium, Ca",
    "Campesterol", "Carbohydrate, by difference", "Carotene, alpha", "Carotene, beta", "Cholesterol",
    "Choline, total", "Copper, Cu", "Cryptoxanthin, beta", "Cystine", "Dihydrophylloquinone",
    "Energy", "Energy (kj)", "Fatty acids, total monounsaturated", "Fatty acids, total polyunsaturated",
    "Fatty acids, total saturated", "Fatty acids, total trans", "Fatty acids, total trans-monoenoic",
    "Fatty acids, total trans-polyenoic", "Fiber, total dietary", "Fluoride, F", "Folate, DFE",
    "Folate, food", "Folate, total", "Folic acid", "Fructose", "Galactose", "Glucose (dextrose)",
    "Glutamic acid", "Glycine", "Histidine", "Hydroxyproline", "Iron, Fe", "Isoleucine", "Lactose",
    "Leucine", "Lutein + zeaxanthin", "Lycopene", "Lysine", "Magnesium, Mg", "Maltose", "Manganese, Mn",
    "Menaquinone-4", "Methionine", "Niacin", "Pantothenic acid", "Phenylalanine", "Phosphorus, P",
    "Phytosterols", "Potassium, K", "Proline", "Protein", "Retinol", "Riboflavin", "Selenium, Se",
    "Serine", "Sodium, Na", "Starch", "Stigmasterol", "Sucrose", "Sugars, total", "Theobromine",
    "Thiamin", "Threonine", "Tocopherol, beta", "Tocopherol, delta", "Tocopherol, gamma", "Total lipid (fat)",
    "Tryptophan", "Tyrosine", "Valine", "Vitamin A, IU", "Vitamin A, RAE", "Vitamin B-12", "Vitamin B-12, added",
    "Vitamin B-6", "Vitamin C, total ascorbic acid", "Vitamin D", "Vitamin D (D2 + D3)",
    "Vitamin D2 (ergocalciferol)", "Vitamin D3 (cholecalciferol)", "Vitamin E (alpha-tocopherol)",
    "Vitamin E, added", "Vitamin K (phylloquinone)", "Water", "Zinc, Zn"
  ]

  keyAliases =
    "Total lipid (fat)":                  "Fat"
    "Carbohydrate, by difference":        "Carbohydrate"
    "Fiber, total dietary":               "Fiber"
    "Alcohol, ethyl":                     "Alcohol"
    "Vitamin A, RAE":                     "Vitamin A" 
    "Vitamin C, total ascorbic acid":     "Vitamin C"
    "Vitamin E (alpha-tocopherol)":       "Vitamin E"
    "Vitamin K (phylloquinone)":          "Vitamin K"
    "Folate, total":                      "Folate"
    "Choline, total":                     "Choline"
    "Calcium, Ca":                        "Calcium"
    "Iron, Fe":                           "Iron"
    "Magnesium, Mg":                      "Magnesium"
    "Manganese, Mn":                      "Manganese"
    "Phosphorus, P":                      "Phosphorus"
    "Potassium, K":                       "Potassium"
    "Sodium, Na":                         "Sodium"
    "Zinc, Zn":                           "Zinc"
    "Glucose (dextrose)":                 "Glucose"
    "Carotene, alpha":                    "Alpha-Carotene"
    "Carotene, beta":                     "Beta-Carotene"
    "Fatty acids, total saturated":       "Saturated fats"
    "Fatty acids, total trans":           "Trans fats"
    "Fatty acids, total monounsaturated": "Monounsaturated fats"
    "Fatty acids, total polyunsaturated": "Polyunsaturated fats"

  calorieKey = "Energy"
  fatKey = "Total lipid (fat)"
  proteinKey = "Protein"
  carbohydrateKey = "Carbohydrate, by difference"
  alcoholKey = "Alcohol, ethyl"

  comparedKeys = _.difference(allKeys, ["NDB_No", "Long_Desc", "FdGrp_Desc"])

  macronutrientKeys = _.extend [
    "Total lipid (fat)"
    "Protein"
    "Carbohydrate, by difference"
    "Fiber, total dietary"
  ],
    text: "Macronutrients"

  fiberKeys = _.extend [
    "Fiber, total dietary"
  ],
    text: "Fiber"
    color: Styles.colors.yellow

  vitaminKeys = _.extend [
    "Vitamin A, RAE"
    "Vitamin C, total ascorbic acid"
    "Vitamin D"
    "Vitamin E (alpha-tocopherol)"
    "Vitamin K (phylloquinone)"
    "Thiamin"
    "Riboflavin"
    "Niacin"
    "Pantothenic acid"
    "Vitamin B-6"
    "Folate, total"
    "Vitamin B-12"
  ],
    text: "Vitamins"
    color: Styles.colors.green

  mineralKeys = _.extend [
    "Calcium, Ca"
    "Iron, Fe"
    "Magnesium, Mg"
    "Manganese, Mn"
    "Phosphorus, P"
    "Potassium, K"
    "Sodium, Na"
    "Zinc, Zn"
  ],
    text: "Minerals"
    color: Styles.colors.violet

  aminoAcidKeys = _.extend [
    "Histidine"
    "Isoleucine"
    "Leucine"
    "Lysine"
    "Methionine"
    "Phenylalanine"
    "Threonine"
    "Tryptophan"
    "Valine"
  ],
    text: "Amino Acids"
    color: Styles.colors.blue

  fattyAcidKeys = _.extend [
    "Fatty acids, total monounsaturated"
    "Fatty acids, total polyunsaturated"
    "Fatty acids, total saturated"
    "Fatty acids, total trans"
  ],
    text: "Fats"
    color: Styles.colors.redYellow

  miscKeys = _.extend [
    "Carotene, alpha"
    "Carotene, beta"
    "Choline, total"
    "Lutein + zeaxanthin"
    "Lycopene"
    "Phytosterols"
    "Cholesterol"
  ],
    text: "Misc"
    color: Styles.colors.greenBlue

  sugarKeys = _.extend [
    "Fructose"
    "Galactose"
    "Glucose (dextrose)"
    "Lactose"
    "Maltose"
    "Sucrose"
    "Sugars, total"
  ],
    text: "Sugars"
    color: Styles.colors.red

  listedKeys = _.union(macronutrientKeys, fiberKeys, vitaminKeys, mineralKeys, 
    aminoAcidKeys, fattyAcidKeys, miscKeys, sugarKeys)

  ignoredKeys = [
    "NDB_No", "Long_Desc", "FdGrp_Desc", "10:0", "12:0", "13:0", "14:0", "14:1", "15:0",
    "15:1", "16:0", "16:1 c", "16:1 t", "16:1 undifferentiated", "17:0", "17:1", "18:0",
    "18:1 c", "18:1 t", "18:1 undifferentiated", "18:1-11t (18:1t n-7)", "18:2 CLAs",
    "18:2 i", "18:2 n-6 c,c", "18:2 t not further defined", "18:2 t,t", "18:2 undifferentiated",
    "18:3 n-3 c,c,c (ALA)", "18:3 n-6 c,c,c", "18:3 undifferentiated", "18:3i", "18:4", "20:0",
    "20:1", "20:2 n-6 c,c", "20:3 n-3", "20:3 n-6", "20:3 undifferentiated", "20:4 n-6",
    "20:4 undifferentiated", "20:5 n-3 (EPA)", "21:5", "22:0", "22:1 c", "22:1 t",
    "22:1 undifferentiated", "22:4", "22:5 n-3 (DPA)", "22:6 n-3 (DHA)", "24:0", "24:1 c",
    "4:0", "6:0", "8:0", "Adjusted Protein", "Alcohol, ethyl", "Ash", "Caffeine", "Energy", "Energy (kj)",
    "Folic acid", "Folate, DFE", "Fatty acids, total trans-monoenoic", "Fatty acids, total trans-polyenoic",
    "Fluoride, F", "Vitamin A, IU", "Vitamin B-12, added", "Vitamin D (D2 + D3)", "Vitamin E, added", "Water",
  ]

  otherKeys = _.extend _.difference(allKeys, listedKeys, ignoredKeys),
    text: "Other"
    color: Styles.colors.greenBlue

  nutrientKeys = _.union(listedKeys, otherKeys)

  unusedKeys = _.difference(allKeys, nutrientKeys)

  loadCsvData = (path, cb) ->
    console.log "Loading .csv: ", path
    d3.csv path, (err, data) ->
      console.error err if err
      cb data

  onLoadCbs = []

  FoodData = {
    loaded: false
    foods: null
    nutrients: null
    foodGroups: []
    selectedFoods: []
    
    macronutrientKeys
    fiberKeys
    vitaminKeys
    mineralKeys
    aminoAcidKeys
    fattyAcidKeys
    miscKeys
    sugarKeys
    otherKeys

    unusedKeys

    findNutrientById: (Nutr_No) -> _.find(@nutrients, (n) -> n.Nutr_No is Nutr_No)

    findFoodById: (id) -> _.find(allFoods, (f) -> f.NDB_No is id)
    findFoodsById: (ids) -> _.compact(@findFoodById id for id in ids)

    # Uses a JS click event because anchors in svgs don't play nicely with every browser.
    getNutrientJSLink: (NutrDesc) ->
      "javascript: window.location = '#{@getNutrientLink(NutrDesc)}';"

    getNutrientLink: (NutrDesc) ->
      "#/nutrients?nutrient=#{@nutrients[NutrDesc].Nutr_No}"

    # Updates `foods` to contain only the enabled `foodGroups`
    updateFoodGroups: ->
      enabledFoodGroups = _.pluck(_.filter(@foodGroups, (g) -> g.enabled), "name")
      @foods = _.filter(allFoods, (f) -> _.contains(enabledFoodGroups, f.FdGrp_Desc))

    areAllFoodGroupsEnabled: (foodGroups = FoodData.foodGroups) -> !_.find(foodGroups, (g) -> !g.enabled)
    getFoodGroupsEnabledCount: (foodGroups = FoodData.foodGroups) -> _.filter(foodGroups, (g) -> g.enabled).length

    # Mutates `foods` with compared values
    calculateRelativeValues: (foods) ->
      for key in comparedKeys
        comparedKey = key + "_Compared"
        max = _.max(foods, (f) -> f[key])[key]
        for food in foods
          if food[key]?
            food[comparedKey] = food[key] / max or 0
      foods

    # Callbacks to execute once data is loaded.
    onLoad: (cb, callIfLoaded = false) -> 
      if !@loaded
        onLoadCbs.push cb
      else if callIfLoaded
        cb()

    # Helper function for proper 2-way routing with asynchronously loaded data.
    # scope is needed because we're going outside of Angular to load data. (replace with $http promises?)
    afterLoading: (scope, cb) ->
      if @loaded
        cb()
      else
        @onLoad ->
          cb()
          scope.$apply()

    databases: _.extend [
      name: "main"
      size: "2.7mb"
      title: "Main database"
      text: "Excludes name brands, beverages, sweets, baby food, a few outliers, and some redundant data for a speedier experience."
      active: true
    ,
      name: "complete"
      size: "3.7mb"
      title: "Complete database"
      text: "Every food available at http://ndb.nal.usda.gov/."
    ,
      name: "vegan"
      size: "0.8mb"
      title: "Vegan database"
      text: "Plants and fungi. Compiled by hand, so if you see an oversight please let me know!"
    ,
      name: "vegetarian"
      size: "1.3mb"
      title: "Vegetarian database (ovo-lacto)"
      text: "Plants, fungi, and meatless animal products. Send me any corrections!"
    ,
      name: "raw"
    ,
      name: "natural"
    ,
      name: "pescatarian"
    ,
      name: "paleo"
    ],
      getPath: (database) -> "data/foods-#{database.name}.csv"
      getActive: -> _.find(FoodData.databases, (d) -> d.active)
      setActive: (database = FoodData.databases.getActive()) ->
        if typeof database is "string"
          database = _.find(FoodData.databases, (d) -> d.name is database)
        return unless database?.name
        lastActive = FoodData.databases.getActive()
        lastActive.active = false
        database.active = true
        if FoodData.loaded
          FoodData.databases.save()
          FoodData.databases.load()
      save: -> window.localStorage?.setItem "food-database", FoodData.databases.getActive().name
      load: (database) ->
        if typeof database is "string"
          database = _.find(FoodData.databases, (d) -> d.name is database)
        if !database
          databaseName = window.localStorage?.getItem("food-database")
          database = _.find(FoodData.databases, (d) -> d.name is databaseName)
        database ?= FoodData.databases.getActive()
        FoodData.loaded = false
        loadCsvData "data/nutrients.csv", (rawNutrients) ->
          FoodData.nutrients = processNutrients(rawNutrients)

          FoodData.benchmarkFood = createBenchmarkFood(FoodData.nutrients)

          loadCsvData "data/foods-#{database.name}.csv", (rawFoods) ->
            FoodData.foods = allFoods = processFoods(rawFoods)

            FoodData.foodGroups = createFoodGroups(FoodData.foods)

            FoodData.databases.setActive database

            FoodData.loaded = true

            # Tell the rest of the app to refresh
            cb() for cb in onLoadCbs
            onLoadCbs = []

            # Refresh once loaded
            $rootScope.$apply()
            console.log "Loaded FoodData", FoodData

  }

  # Initialize the database
  FoodData.databases.load()

  # Convert array of nutrients to objected keyed by nutrient name
  processNutrients = (rawNutrients) ->
    data = {}
    for item in rawNutrients
      data[item.NutrDesc] = item
      item.text = keyAliases[item.NutrDesc] or item.NutrDesc
    data

  processFoods = (foods) ->
    foods = _.sortBy(foods, (f) -> f.Long_Desc)
    for food in foods
      processFood food
    foods

  # Prepare food data using the formula nutrients/calories
  processFood = (food) ->
    # Parse strings to numbers and clean up empty values
    for k, v of food
      if _.contains(comparedKeys, k)
        if v
          food[k] = parseFloat(v)
        else
          delete food[k]

    # Convert nutrients/100g to nutrients/calorie by dividing by calories/100g
    ignoredKeys = [calorieKey, "Energy (kj)", "Total lipid (fat)", "Protein", "Carbohydrate, by difference"] # TODO TODO TODOOOOOOOOOOO
    calories = food[calorieKey]
    for k, v of food
      if typeof v is "number" and not _.contains(ignoredKeys, k)
        if calories
          food[k] = v / calories
        else
          food[k] = -v # water...

    # Convert fat, protein, carbohydrate, and alcohol to percentages of the whole
    food[fatKey] or= 0
    food[proteinKey] or= 0
    food[carbohydrateKey] or= 0
    food[alcoholKey] or= 0

    # Calculate by subtraction, ignoring the carbohydrate data
    # food[fatKey] = (food[fatKey] * 9) / food[calorieKey]
    # food[proteinKey] = (food[proteinKey] * 4) / food[calorieKey]
    # food[alcoholKey] = (food[alcoholKey] * 7) / food[calorieKey]
    # food[carbohydrateKey] = 1 - food[fatKey] - food[proteinKey] - food[alcoholKey]

    # Calculate by macronutrient amounts, ignoring the energy data
    calculatedCalorieKey = "Calories, calculated"
    food[fatKey] *= 9
    food[proteinKey] *= 4
    food[carbohydrateKey] *= 4
    food[alcoholKey] *= 7
    food[calculatedCalorieKey] = food[fatKey] + food[proteinKey] + food[carbohydrateKey] + food[alcoholKey]
    food[fatKey] /= food[calculatedCalorieKey]
    food[proteinKey] /= food[calculatedCalorieKey]
    food[carbohydrateKey] /= food[calculatedCalorieKey]
    food[alcoholKey] /= food[calculatedCalorieKey]
    
    food

  createFoodGroups = (foods) ->
    foodGroups = []
    for food, i in foods
      if !_.find(foodGroups, (g) -> g.name is food.FdGrp_Desc)
        foodGroups.push 
          name: food.FdGrp_Desc
          id: "food-group-#{i}"
          enabled: true
    for group in foodGroups
      group.count = _.filter(foods, (f) -> f.FdGrp_Desc is group.name).length
    _.sortBy(foodGroups, (f) -> f.name)

  createBenchmarkFood = (nutrients) ->
    benchmarkFood = {}

    # RDI is still used on nutrition labels, but the more modern DRI is also included - TODO option switch to DRI
    benchmarkKey = "RDI"

    # Copy the benchmark values from the nutrients table
    for key, value of nutrients
      benchmarkValue = value[benchmarkKey]
      if benchmarkValue
        benchmarkFood[key] = benchmarkValue

    benchmarkFood.Long_Desc = "Recommended daily intake"
    benchmarkFood.NDB_No = "0"
    benchmarkFood[calorieKey] = 2000

    # Reuse the process function
    benchmarkFood = processFood(benchmarkFood)

  FoodData


app.factory "Presets", (FoodData, ComparePage) ->

  defaultPresets = [
    text: "Brown rice vs white rice"
    foods: "20037,20445"
  ,
    text: "Wheat flour vs white flour"
    foods: "20080,20481"
  ,
    text: "Vegetable protein - not just from beans!"
    foods: "11096,11090,11233,11457,11019,16043,16015,20137"
  ,
    text: "Greens and meats"
    foods: "11457,11161,11250,05009,13443"
  ,
    text: "Calcium (doesn't account for absorption!)"
    foods: "11161,11096,11457,01079,01026,01009"
  ,
    text: "Beans vs rice"
    foods: "16043,20041"
  ]

  presetSaveKey = "presets"

  savedPresets = window.localStorage.getItem(presetSaveKey)
  savedPresets = JSON.parse(savedPresets) if savedPresets

  data =
    save: -> window.localStorage.setItem(presetSaveKey, JSON.stringify(data.presets))
    create: (text) ->
      preset = 
        text: text
        foods: _.pluck(ComparePage.selectedFoods, "NDB_No").join(",")
      data.presets.unshift preset
      data.save()
    presets: savedPresets or defaultPresets
    add: (text, foods) ->
      data.presets.push {text, foods}
      data.save()
    remove: (preset) ->
      data.presets = _.without(data.presets, preset)
      data.save()
    activate: (preset) ->
      ids = preset.foods.split(",")
      foods = FoodData.findFoodsById(ids)
      ComparePage.reset foods