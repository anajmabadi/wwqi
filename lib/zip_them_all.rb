require 'rubygems'
require 'zip/zipfilesystem'

# derived from http://railstalk.com/2009/8/6/create-a-zip-file-using-ruby

class ZipThemAll
    attr_accessor :list_of_file_paths, :zip_file_path
    def initialize( zip_file_path, list_of_file_paths )
        @zip_file_path = zip_file_path
        list_of_file_paths = [list_of_file_paths] if list_of_file_paths.class == String
        @list_of_file_paths = list_of_file_paths
    end

    def zip
        zip = Zip::ZipFile.open(self.zip_file_path, Zip::ZipFile::CREATE) do | zipfile |
            @list_of_file_paths.each do | file_path |
                if File.exists?file_path
                    file_name = File.basename( file_path )
                    if zipfile.find_entry( file_name )
                    zipfile.replace( file_name, file_path )
                    else
                    zipfile.add( file_name, file_path)
                    end
                else
                    puts "Warning: file #{file_path} does not exist"
                end
            end
        end

    end
end