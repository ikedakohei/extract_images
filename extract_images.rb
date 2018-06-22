require 'fileutils'
require 'zip' #rubyzip gem

Zip.on_exists_proc = true

print "Folder: "
# フォルダ名を入力 （例）C:\hogehoge
@dir_name = File.expand_path(gets.chomp)

# フォルダ内のファイルから画像を抽出
def extract_images(extension, file)
  Dir.glob("#{@dir_name}/**/*.#{extension}").each do |path_name|
    dir_file_name = "#{File.dirname(path_name)}/#{File.basename(path_name, '.*')}"
    Dir.mkdir(dir_file_name) unless Dir.exist?(dir_file_name)
    # 空ファイルでない場合のみ実行
    unless File.zero?(path_name)
      Zip::File.open(path_name) do |zipfile|
        entries = zipfile.glob("#{file}/media/*")
        entries.each do |entry|
          entry.extract("#{dir_file_name}/#{File.basename(entry.name)}")
        end
      end
      puts path_name # コンソール上にファイル名を表示
    end
  end
end

extract_images("docx", "word")
extract_images("pptx", "ppt")
extract_images("xlsx", "xl")

puts "\nFinish!" # コンソール上で完了したことを示す
