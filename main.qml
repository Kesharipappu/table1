import QtQuick 2.15
import QtQuick.Controls 1.4
import QtQuick.LocalStorage 2.15

ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: "SQLite Table in QML"

    ListModel {
        id: tableModel
    }

    Component.onCompleted: {
        // Open the database
        var db = LocalStorage.openDatabaseSync("MyDatabase", "1.0", "Database for my app", 1000000);

        // Execute a query
        var resultSet = db.executeSql("SELECT * FROM student");

        // Populate the model for TableView
        for (var i = 0; i < resultSet.rows.length; i++) {
            tableModel.append({
                name: resultSet.rows.item(i).name,
                fatherName: resultSet.rows.item(i).fatherName
            });
        }
    }

    TableView {
        id: tableView
        anchors.fill: parent
        model: tableModel

        TableViewColumn {
            role: name
            title: "Name"
            width: 100
        }

        TableViewColumn {
            role: fatherName
            title: "Father's Name"
            width: 100
        }
    }
}
