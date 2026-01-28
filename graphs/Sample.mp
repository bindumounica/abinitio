graph CSG_Example_Graph
  
  // Components (Nodes)
  component InputFile [Type: Read_File] {
    file: "/data/input.txt",
    format: "string"
  }
  
  component ReformatData [Type: Reformat] {
    transform: "out.name :: string_upcase(in.name);"
  }
  
  component OutputFile [Type: Write_File] {
    file: "/data/output.txt"
  }
  
  // Flows (Edges)
  flow F1 {
    source: InputFile.output_port,
    target: ReformatData.input_port
  }
  
  flow F2 {
    source: ReformatData.output_port,
    target: OutputFile.input_port
  }
end
