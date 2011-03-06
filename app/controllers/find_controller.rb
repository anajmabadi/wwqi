class FindController < ApplicationController
  def item
  	# get the id for the item
  	@id = params[:id].to_i unless params[:id].nil?
  	# redirect to item page or fail
  	respond_to do |format|
      unless @id.nil? || @id == 0
        format.html { redirect_to(archive_detail_path(@id) ) }
      else
        format.html { redirect_to(archive_path, :flash => { :error => I18n.translate(:showing_no_records) }) }
      end
    end
  end

  def collection
  	  	# get the id for the item
  	@id = params[:id].to_i unless params[:id].nil?
  	# redirect to item page or fail
  	respond_to do |format|
      unless @id.nil? || @id == 0
        format.html { redirect_to(archive_collection_detail_path(@id) ) }
      else
        format.html { redirect_to(archive_collections_path, :flash => { :error => I18n.translate(:showing_no_records) }) }
      end
    end
  end

end
