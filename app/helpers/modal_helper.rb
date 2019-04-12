module ModalHelper
  def modal_link_to(name, url, addclass: '', title: '')
    link_to name, url, class: "modal-link #{addclass}", modal: true, title: title
  end

  def dm_modal_js_helper
    javascript_tag do
      raw %Q|
  $('.modal-link').click(function(event){
    event.preventDefault();
    var url = $(this).attr('href');
    var separator = url.indexOf('?') > -1 ? '&' : '?';
    $('#main-modal .modal-body').load(url + separator + "modal=yyy");
    $('#main-modal').modal('show');
  });
  |
    end
  end

  def bootstrap_modal_div
    raw %Q|
      <div class="modal fade" id="main-modal" tabindex="-1" role="dialog" aria-labelledby="main_modal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered " role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title"></h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true" style="font-size: 42px">&times;</span></button>
            </div>
            <div class="modal-body">
            </div>
          </div><!-- .modal-content -->
        </div><!-- .modal-dialog -->
      </div><!-- .modal -->
      |
  end
end
