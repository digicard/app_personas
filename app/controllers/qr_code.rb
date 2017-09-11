module QrCode

	def generate_QR(ap, nb, dni)
		seed = ap + ', ' + nb + ', ' + dni
		qrcode = RQRCode::QRCode.new(seed, :size => 2, :level => :m, :mode => :number)
		# With default options specified explicitly
		png = qrcode.as_png(
          resize_gte_to: false,
          resize_exactly_to: false,
          fill: 'white',
          color: 'black',
          size: 120,
          border_modules: 4,
          module_px_size: 6,
          file: nil # path to write
          )

		path = 'app/assets/images/' + seed + '.png'
		qrpath = '/assets/' + seed + '.png'

		File.open(path, 'wb') do |f|
			f.write(png)
		end

		return qrpath
	end

end