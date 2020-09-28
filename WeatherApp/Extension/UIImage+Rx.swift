

import SDWebImage

extension Reactive where Base: UIImageView {
    var imageUrl: Binder<String> {
        return Binder(base) { imageView, imageUrl in
            imageView.sd_setImage(with: URL(string: imageUrl))
        }
    }
}

