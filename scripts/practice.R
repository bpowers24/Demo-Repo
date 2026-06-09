read_csv("data/penguin_species.csv")
read_csv("data/penguin_measurements.csv")

penguin_species = read_csv("data/penguin_species.csv")
penguin_measurements = read_csv("data/penguin_measurements.csv")

joined_data = left_join(penguin_measurements, penguin_species, by = "species_id")

adelie = filter(joined_data, common_name == "Adelie")

