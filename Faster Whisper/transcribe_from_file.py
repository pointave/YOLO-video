import sys
import subprocess
from faster_whisper import WhisperModel

def transcribe_file(file_path):
    model_size = "large-v3"
    model = WhisperModel(model_size, device="cuda", compute_type="float16")
    segments, info = model.transcribe(file_path, beam_size=5)
    print("Detected language '%s' with probability %f" % (info.language, info.language_probability))

    # Always print to file
    output_file_name = file_path.split('.')[0] + "_transcribed.txt"
    with open(output_file_name, 'w', encoding='utf-8') as f:
        include_timestamps = input("Do you want to include timestamps? (yes/no, default: no): ").lower()
        if include_timestamps == "yes":
            for segment in segments:
                f.write("[%.2fs -> %.2fs] %s\n" % (segment.start, segment.end, segment.text))
        else:
            for segment in segments:
                f.write("%s\n" % (segment.text))
    print("Transcribed text has been written to %s" % output_file_name)

    # Open the text file using the default application associated with .txt files
    try:
        subprocess.Popen(["start", "", output_file_name], shell=True)
    except FileNotFoundError:
        print("Failed to open the text file. Please open it manually.")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python transcribe_from_file.py <file_path>")
        sys.exit(1)
    file_path = sys.argv[1]
    transcribe_file(file_path)
