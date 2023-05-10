function main()
    # Read in the Vina log file as a vector of strings
lines = readlines("./log.log")
println("diff")
# Loop over the lines and extract the energy values
energy_values = []
for line in lines
    if contains(line, "1" || "2")
        println(line)
        # Split the line into individual tokens
        tokens = split(line, " ")
        # Extract the energy value (which is the second-to-last token)
        energy = parse(Float64, tokens[end-1])
        push!(energy_values, energy)
    end
end

# Print the energy values to the console
println(energy_values)

end

main()

# function main()
#     # Open the output file for reading
# io = open("./log.txt", "r")
# # Find the line that contains the main energy values
# global energy_line = ""
# for line in eachline(io)
#     if contains(line, "Refining results ")
#         println(line)
#         energy_line = line
#         break
#     end
# end

# # Close the input file
# close(io)

# # Extract the main energy values
# energy_values = split(energy_line, " ")[4:end]
# names = ["Affinity", "RMSD LB", "RMSD UB", "Intermolecular Energy", "Intramolecular Energy", "Total Energy"]
# energy_dict = Dict(name => parse(Float64, value) for (name, value) in zip(names, energy_values))

# # Print the energy values
# for (name, value) in energy_dict
#     println("$name: $value")
    
# end

# end

# main()