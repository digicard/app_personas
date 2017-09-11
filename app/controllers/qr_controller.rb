class QrController < ApplicationController
	require 'rqrcode'

	def qr_view

	end

	def show
		@person = Person.joins(:person_ca).find(params[:id])
	end

	def generate_QR
		seed = random_number128
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
	helper_method :generate_QR

	def random_number128
		i = 0
		n = ''
		while i < 16
			n += rand(9).to_s
			i += 1
		end
		return n;
	end
end