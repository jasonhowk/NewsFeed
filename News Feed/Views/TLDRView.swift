//
//  TLDRView.swift
//  News Feed
//
//  Created by Jason Howk on 8/8/18.
//  Copyright © 2018 Rude Tie, LLC. All rights reserved.
//

import UIKit

class TLDRView: UIView {
    private let dateFormatString = "MMM d yyyy h:mm a"

    private var tldrLabel: UILabel!
    private var publishedLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var dateFormatter:DateFormatter!
    
    var articlePublishedDate:Date? {
        didSet {
            guard let date = articlePublishedDate else { return }
            publishedLabel.text = dateFormatter.string(from: date)
        }
    }
    
    var articleDescription:String? {
        didSet {
            guard let articleDescription = articleDescription else { return }
            descriptionLabel.text = articleDescription
        }
    }
    
    convenience init(published:Date, description:String) {
        self.init(frame: .zero)
        configureView()
        
        articlePublishedDate = published
        articleDescription = description
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    // MARK: - Private
    private func configureView() {
        dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.setLocalizedDateFormatFromTemplate(dateFormatString)
        
        backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.0)
        
        tldrLabel = UILabel()
        tldrLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        tldrLabel.text = "TL;DR"
        tldrLabel.textColor = UIColor(hue: 0, saturation: 0, brightness: 0.13, alpha: 1.0)
        addSubview(tldrLabel)
        
        publishedLabel = UILabel()
        publishedLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        publishedLabel.textColor = .gray
        addSubview(publishedLabel)
        
        descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionLabel.sizeToFit()
        addSubview(descriptionLabel)
        
        // Constraints
        let marginsGuide = self.layoutMarginsGuide
        
        tldrLabel.translatesAutoresizingMaskIntoConstraints = false
        publishedLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints:[NSLayoutConstraint] = [
            tldrLabel.topAnchor.constraint(equalTo: marginsGuide.topAnchor, constant: 8.0),
            tldrLabel.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor, constant: 8.0),
            publishedLabel.centerYAnchor.constraint(equalTo: tldrLabel.centerYAnchor),
            publishedLabel.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor, constant: -8.0),
            descriptionLabel.topAnchor.constraint(equalTo: tldrLabel.bottomAnchor, constant: 8.0),
            descriptionLabel.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor, constant: 8.0),
            descriptionLabel.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor, constant: -8.0),
            descriptionLabel.bottomAnchor.constraint(equalTo: marginsGuide.bottomAnchor, constant: -8.0)
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
}
