require 'fileutils'
require 'zip' #rubyzip gem

Zip.on_exists_proc = true

print "Folder: "
# フォルダ名を入力 （例）C:\hogehoge
dir_name = File.expand_path(gets.chomp)

# フォルダ内のdocxファイルから画像を抽出
Dir.glob("#{dir_name}/**/*.docx").each do |path_name|
  Dir.mkdir("#{File.dirname(path_name)}/#{File.basename(path_name, '.*')}")
  # 空ファイルでない場合のみ実行
  unless File.zero?(path_name)
    Zip::File.open(path_name) do |zipfile|
      entries = zipfile.glob("word/media/*")
      entries.each do |entry|
        entry.extract("#{File.dirname(path_name)}/#{File.basename(path_name, '.*')}/#{File.basename(entry.name)}"){ true }
      end
    end
    puts path_name # コンソール上にファイル名を表示
  end
end

puts "\nFinish!" # コンソール上で完了したことを示す
