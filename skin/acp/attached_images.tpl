{* Attached Images Template *}
<link rel="stylesheet" type="text/css" href="{$SKIN}/jquery-ui-1.10.3.custom.min.css" media="screen" />
<script type="text/javascript" src="{$SKIN}/jquery-ui-1.10.3.custom.min.js"></script>

<p class="attached-images">
{foreach from=$attachimg item=img}
	<span class="thumbnail visible-inline hover-without-underline text-right" width="160" id="imga-{$img['id']}">
		<a href="/upload/images/{$img['resize']}" data-fancybox="gallery" data-animation-duration="300" data-caption="{$img['alt']}"><img src="/upload/images/{$img['thumb']}" class="attach-img" id="aimage-{$img['id']}" alt="{$img['alt']}" rel="tooltip" title="{$img['alt']}" data-placement="top"></a>
		<input type="text" class="form-control input-sm input-alt-text" id="altimage-{$img['id']}" name="alt[{$img['id']}]" value="{$img['alt']}" placeholder="---">
		<span class="btn btn-link btn-xs hover-without-underline op_attached_images pull-left handlesort"><i class="fa fa-fw fa-arrows"></i></span>
		<span id="imgoption-{$img['id']}">
			<span class="btn btn-link btn-xs hover-without-underline op_attached_images" id="delimage-{$img['id']}" rel="tooltip" title="Удалить" data-placement="left"><i class="fa fa-trash-o fa-fw"></i></span>
		</span>
		<input type="hidden" name="sort[{$img['id']}]" value="{$img['sort']}">
	</span>
{/foreach}

{literal}
<script>
	$(document).ready(function(){
		$('span[id^=delimage]').click(function() {
			var attrdata = $(this).attr('id');
			var arrdata = attrdata.split('-');
			var id = arrdata[1];

			$("#aimage-"+id).animate({'opacity':'0'}, 300, function() {
				$("#imgoption-"+id).load('/acp.php?act=ajax&part=delete_attached_image&id='+id, function() {
					$("#imga-"+id).animate({'opacity':'0'}, 750, function() {
						$("#imga-"+id).hide(600).delay(900).remove();
					});
				});
			});
		});

		$('.attached-images').sortable({
			connectWith: '.attached-images',
			opacity: 0.8,
			handle: '.handlesort',
			stop: function(event, ui) {
				var i = 1;
				$(this).children(".thumbnail").each(function() {
					$(this).children("input[name^='sort']").val(i);
					i++;
				});
			}
		}).disableSelection();
	});
</script>
{/literal}
