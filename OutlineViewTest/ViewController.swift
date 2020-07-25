import Cocoa

class ViewController: NSViewController {
    @IBOutlet var outlineView: NSOutlineView?

    let data = [Node("First item", 1), Node("Second item", 2)]
}


extension ViewController: NSOutlineViewDataSource {
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        data[index]
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        true
    }
    
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        item == nil ? data.count : 0
    }
    
    func outlineView(_ outlineView: NSOutlineView, objectValueFor tableColumn: NSTableColumn?, byItem item: Any?) -> Any? {
        item
    }
    
    func outlineView(_ outlineView: NSOutlineView, persistentObjectForItem item: Any?) -> Any? {
        (item as? Node)?.id
    }
    
    func outlineView(_ outlineView: NSOutlineView, itemForPersistentObject object: Any) -> Any? {
        guard let id = object as? Int else { return nil }
        return data.first { $0.id == id }
    }
}


extension ViewController: NSOutlineViewDelegate {
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        guard let node = item as? Node else {
            preconditionFailure("Invalid data item \(item)")
        }
        let view = outlineView.makeView(withIdentifier: nodeCellIdentifier, owner: self) as? NSTableCellView
        view?.textField?.stringValue = node.name
        view?.imageView?.image = NSImage(systemSymbolName: node.icon, accessibilityDescription: nil)
        return view
    }
}


final class Node {
    let id: Int
    let name: String
    let icon: String
    
    init(_ name: String, _ id: Int, _ icon: String = "folder") {
        self.id = id
        self.name = name
        self.icon = icon
    }
}

private let nodeCellIdentifier = NSUserInterfaceItemIdentifier("DataCell")
