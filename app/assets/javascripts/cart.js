$('.quantity').change(function () {
  self = $(this);
  $.ajax({
    url: '/update_subtotal/',
    method: 'post',
    data: {
      product_id: self.data('product'),
      quantity: self.val()
    },
    dataType: 'script'
  });
});
