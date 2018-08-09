//
//  MasterTableViewCell.swift
//  News Feed
//
//  Created by Jason Howk on 8/8/18.
//  Copyright © 2018 Rude Tie, LLC. All rights reserved.
//

import UIKit

class MasterTableViewCell: UITableViewCell {
    
    private var heroImageView: UIImageView!
    private var sourceLabel: UILabel!
    private var titleLabel: UILabel!
    
    var article:Article? {
        didSet {
            sourceLabel.text = article?.source.name
            titleLabel.text = article?.title
            ServiceCoordinator.sharedInstance.imageServer.requestImageFromURL(article?.imageURL, completionHandler: { [weak self] (image, error) in
                guard let strongSelf = self else { return }
                DispatchQueue.main.async {
                    strongSelf.heroImageView.image = image
                }
            })
            setNeedsLayout()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        sourceLabel = UILabel()
        sourceLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        titleLabel = UILabel()
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.numberOfLines = 0
        heroImageView = UIImageView()
        heroImageView.clipsToBounds = true
        heroImageView.contentMode = .scaleAspectFill
        
        contentView.addSubview(sourceLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(heroImageView)

        // Constraints
        let marginsGuide = contentView.layoutMarginsGuide
        
        heroImageView.translatesAutoresizingMaskIntoConstraints = false
        sourceLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let constraints:[NSLayoutConstraint] = [
            heroImageView.topAnchor.constraint(equalTo: marginsGuide.topAnchor, constant: 8.0),
            heroImageView.heightAnchor.constraint(equalToConstant: 300),
            heroImageView.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor),
            heroImageView.widthAnchor.constraint(equalTo: marginsGuide.widthAnchor),
            sourceLabel.topAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: 8.0),
            sourceLabel.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: 8.0),
            titleLabel.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: marginsGuide.bottomAnchor, constant: -8.0)
        ]
        NSLayoutConstraint.activate(constraints)
        
        // DEBUG
        // contentView.backgroundColor = .gray
        // sourceLabel.backgroundColor = .red
        // titleLabel.backgroundColor = .blue
        // heroImageView.backgroundColor = .green
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: animated)
        
        // Do nothing.  We want the cell to be selectable without the UI changes as it will immediately
        // invoke a transition.
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        heroImageView.image = nil
        sourceLabel.text = ""
        titleLabel.text = ""
    }
    
    

}
