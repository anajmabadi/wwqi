# coding: utf-8

# To change this template  choose Tools | Templates
# and open the template in the editor.

# application constants
STABLE_URL = "http://www.qajarwomen.org/"
LIBRARY_URL = "http://library.qajarwomen.org/"
DEVELOPMENT_LIBRARY_PATH = "/volumes/passport/project_libraries/qajar_library/pub/"
PRODUCTION_LIBRARY_PATH = "/var/www/vhosts/qajarwomen.org/subdomains/library/httpdocs/"
LIBRARY_PATH = Rails.env == "production" ?  PRODUCTION_LIBRARY_PATH : DEVELOPMENT_LIBRARY_PATH
PREVIEWS_DIR = "previews/"
SLIDES_DIR = "slides/"
TIFS_DIR = "tifs/"
THUMBNAILS_DIR = "thumbs/"
COLLECTION_THUMBNAILS_DIR = "collection_thumbs/"
ZIPS_DIR = "zips/"
PDFS_DIR = "pdfs/"
ICONS_DIR = "icons/"
FINDING_AID_DIR = "finding_aids/"
COLLECTION_PREFIX = "collection_"
ZOOMIFY_DIR = "zoomify/"
CLIPS_DIR = "clips/"
FILE_PREFIX = "it_"
COOKIE_DOMAIN = Rails.env == 'development' ? '.qajar_women.local' : '.qajarwomen.org'


ARCHIVE_REFINE_RESULTS_MORE_SHOW_LIMIT = 1000
ARCHIVE_REFINE_RESULTS_TOP_SHOW_LIMIT = 8