class_name FileLoader

static func save_to_file(path:String, file_name: String, data: String) -> void:
	if !DirAccess.dir_exists_absolute(path):
		DirAccess.make_dir_recursive_absolute(path)
	
	var full_path: String = path + file_name
	
	var file = FileAccess.open(full_path, FileAccess.WRITE)
	if file == null:
		push_error("Failed to open file for writing: %s" % full_path)
		return
	
	file.store_string(data)
	file.close()

static func load_file_data(path: String, file_name: String):
	var full_path: String = path + file_name
	
	if !FileAccess.file_exists(full_path): return null
	
	var file := FileAccess.open(full_path, FileAccess.READ)
	if file == null:
		push_error("Failed to open file for writing: %s" % full_path)
		return
	
	var data := file.get_as_text()
	file.close()
	return data
