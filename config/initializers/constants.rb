# coding: utf-8

# To change this template  choose Tools | Templates
# and open the template in the editor.

# application constants
LIBRARY_URL = "http://library.qajarwomen.org/"
DEVELOPMENT_LIBRARY_PATH = "/volumes/passport/project_libraries/qajar_library/pub/"
PRODUCTION_LIBRARY_PATH = "/var/www/vhosts/qajarwomen.org/subdomains/library/httpdocs/"
LIBRARY_PATH = Rails.env == "production" ?  PRODUCTION_LIBRARY_PATH : DEVELOPMENT_LIBRARY_PATH
PREVIEWS_DIR = "previews/"
SLIDES_DIR = "slides/"
TIFS_DIR = "tifs/"
THUMBNAILS_DIR = "thumbs/"
ZIPS_DIR = "zips/"
FINDING_AID_DIR = "finding_aids/"
COLLECTION_PREFIX = "collection_"
ZOOMIFY_DIR = "zoomify/"
CLIPS_DIR = "clips/"
FILE_PREFIX = "it_"

ARCHIVE_BROWSER_PEOPLE_ITEMS_LIMIT = 20
ARCHIVE_BROWSER_PLACES_ITEMS_LIMIT = 5
ARCHIVE_BROWSER_SUBJECTS_ITEMS_LIMIT = 20
ARCHIVE_REFINE_RESULTS_SHOW_LIMIT = 5