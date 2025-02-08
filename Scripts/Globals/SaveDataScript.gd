class_name SaveData extends Resource

@export var best_time: int = 0

const SAVE_PATH:String = "user://pete_the_pig_save.tres"

func save():
	ResourceSaver.save(self, SAVE_PATH)
	
static func load_or_create() -> SaveData:
	var res: SaveData
	if FileAccess.file_exists(SAVE_PATH):
		print("Save file exists. Loading...")
		res = load(SAVE_PATH) as SaveData
		if res == null:
			print("Error: Loaded save data is null. Creating a new one.")
			res = SaveData.new()
	else:
		print("Save file does not exist. Creating a new one.")
		res = SaveData.new()
	return res
