-- 608.Tree Node

--  Given a table TREE, id is identifier of the tree node and p_id is its parent node's id.
-- 下表中，id 為每一個節點的編號，p_id 為每個節點的父節點。
--  +----+------+
--  | id | p_id |
--  +----+------+
--  | 1  | null |
--  | 2  | 1    |
--  | 3  | 1    |
--  | 4  | 2    |
--  | 5  | 2    |
--  +----+------+
--  Each node in the tree can be one of three types:
--  Leaf: if the node is a leaf node.
--  Root: if the node is the root of the tree.
--  Inner: If the node is neither a leaf node nor a root node.   
--  樹中的每個節點可以是以下三種類型之一：
--  葉：如果節點是葉節點。
--  根：如果節點是樹的根。
--  內部：如果節點既不是'葉節點'也不是'根節點'。

--  Write a query to print the node id and the type of the node. 
-- 列出每一個節點及其所屬類型
-- Sort your output by the node id. 
-- 按節點 ID 對輸出進行排序

-- The result for the above sample is:   
--  +----+------+
--  | id | Type |
--  +----+------+
--  | 1  | Root |
--  | 2  | Inner|
--  | 3  | Leaf |
--  | 4  | Leaf |
--  | 5  | Leaf |
--  +----+------+ 
--  Explanation  
--  Node '1' is root node, because its parent node is NULL and it has child node '2' and '3'.
--  節點'1' 是根節點，因為它的父節點是 NULL 並且它有子節點 '2' 和 '3'。
--  Node '2' is inner node, because it has parent node '1' and child node '4' and '5'.
--  節點'2' 是內部節點，因為它有父節點'1'和子節點'4'和'5'。
--  Node '3', '4' and '5' is Leaf node, because they have parent node and they don't have child node.
--  節點'3'、'4'和'5'是葉子節點，因為它們有父節點而沒有子節點。

--  And here is the image of the sample tree as below:  
--             1
--           /   \
--          2     3
--        /   \
--       4     5
--  Note: If there is only one node on the tree, you only need to output its root attributes.
--  如果樹上只有一個節點，則只需輸出其根屬性即可。


-- Solution
SELECT ID,
CASE WHEN P_ID IS NULL THEN 'Root' -- 根節點(無父)
     -- 葉節點(無子):判斷節點不在"所有父節點"之中
     WHEN ID NOT IN (SELECT P_ID FROM TREE WHERE P_ID IS NOT NULL GROUP BY P_ID) THEN 'Leaf'
     -- 內節點(有父有子)
     ELSE 'Inner'
     END AS TYPE
FROM TREE
ORDER BY ID;
