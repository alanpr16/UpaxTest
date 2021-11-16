//
//  GraphsViewController.swift
//  UpaxTest
//
//  Created by Alan on 15/11/21.
//

import UIKit

final class GraphsViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = AutosizingTableView()
        tableView.register(GraphTableViewCell.self, forCellReuseIdentifier: GraphTableViewCell.reuseIdentifier)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    var questions: [QuestionViewData] = []
    
    let graphsPresenter: GraphsPresenter
    
    init(presenter: GraphsPresenter) {
        self.graphsPresenter = presenter
        super.init(nibName: nil,
                   bundle: Bundle(for: type(of: self)))
        graphsPresenter.setView(delegate: self)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view.backgroundColor = .systemGray6
        view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        graphsPresenter.getInfoGraphs()
        overrideUserInterfaceStyle = .unspecified
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate(
            [tableView.topAnchor.constraint(equalTo: guide.topAnchor),
             tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
             tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
             tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor)])
    }
}

extension GraphsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}

extension GraphsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: GraphTableViewCell.reuseIdentifier,
                                                     for: indexPath) as? GraphTableViewCell
        else {
            return UITableViewCell()
        }
        cell.question = questions[indexPath.row]
        return cell
    }
}

extension GraphsViewController: GraphsPresenterDelegate {
    func display(questions: [QuestionViewData]) {
        self.questions = questions
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
