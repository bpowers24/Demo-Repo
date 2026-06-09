read_csv("data/penguin_species.csv")
read_csv("data/penguin_measurements.csv")

penguin_species = read_csv("data/penguin_species.csv")
penguin_measurements = read_csv("data/penguin_measurements.csv")

joined_data = left_join(penguin_species, penguin_measurements, by = "species_id")

adelie = filter(joined_data, common_name == "Adelie")

island_body_mass = group_by(adelie, common_name, island)
island_body_mass = summarize(island_body_mass, mean_body_mass_g = mean(body_mass_g, na.rm = TRUE, .groups = "Drop"))
print(island_body_mass, digits = 10)
