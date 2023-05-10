using Mongoc
using Chemfiles
using BioStructures


# nameOfFolder = ARGS[1]
# # number of molecules generation
# num_m = ARGS[2]


client = Mongoc.Client("mongodb://localhost:1000")

db = client["tasks"]
collection = db["prototype"]

# Define the paths to the protein and ligand folders
protein_folder = "../uploads/proteins"
ligand_folder = "../uploads/ligands"

# Get a list of all the protein and ligand files in the folders
protein_files = readdir(protein_folder)
ligand_files = readdir(ligand_folder)

println("🌳 Done ")
# Loop over all the protein-ligand pairs and run the Vina calculations
for protein_file in protein_files
    println("🌳 Done ")
    for ligand_file in ligand_files
        println("🌳 Done ")
        println("🌳 Done 04")
        
        # Run the Vina calculations using the appropriate command
        command = `./vina --config ./config.txt --receptor ../uploads/proteins/$protein_file --ligand ../uploads/ligands/$ligand_file  --out output.pdbqt --log log.log`
        # command = `./vina --config ./config.txt --receptor $protein_PDBQT --ligand $ligand_PDBQT  --out output.pdbqt --log log.txt`
        println("🌳 Done 05")
        run(command)
        println("🌳 Done 06")
        
        energy = readlines("./log.log")
        # Create a BSON document to store the results in MongoDB
        document = Mongoc.BSON("protein" => protein_file,
                                  "ligand" => ligand_file,
                                  "energy" => energy,
                                  "output" => "blocked")
        
        # Insert the document into the MongoDB collection
        res = Mongoc.insert_one(collection, document)
        # res = Mongoc.insert_one(document,Mongoc.BSON)
        
    end
end


# # import Pkg

# # Pkg.add("MongoDB")

# using Pkg, Mongoc, JSON, BioCore

# # Connect to MongoDB
# client = Mongoc.Client("mongodb://localhost:27017")
# db = client["mydatabase"]
# collection = db["mycollection"]

# # Load Julia packages
# Pkg.add("BioStructures")
# using BioStructures





# # Load protein structure from file
# protein_file = "upload/proteins/myprotein.pdb"
# protein = readpdb(protein_file)

# # protein = read(protein_file, PDBFile)

# # Load ligand structure from file
# ligand_file = "upload/ligand/myligand.pdb"
# ligand = readpdb(ligand_file)

# # Run protein-ligand docking simulation
# result = dock(protein, ligand)

# # Save output file
# output_file = "output/output.pdb"
# writepdb(output_file, result)

# # Save result in MongoDB as a JSON document
# document = Dict(
#     "protein_file" => protein_file,
#     "ligand_file" => ligand_file,
#     "output_file" => output_file,
#     "result" => result
# )
# insert_one(collection, document |> JSON.json)


# # include("logic/command.jl")

# # function main()
    

# #     fetchMol()
# # end


# # function fetchMol()
    
# #     # fetch Ligand
# #     # fetch receptor
# #     # fetch config
# #     # fetch user id
# #     # create a woking document in mongodb

# #     # create Config file


# #     # let path name
# # path = pwd()
# #     molPath = "$path/quercetin.mol2"
# #     rececptorPath = "$path/7aad.pdbqt"
# #     config = "$path/config.txt"

# #     # always check conversion
# #     # needs conversion
# #     dockingRun(molPath,rececptorPath,config)

    

# #     # can pass to autodock only after passing conversion layer
    


# # end

# # # one mol at a time


# # main()