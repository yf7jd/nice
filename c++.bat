#include <iostream>
#include <queue>


using namespace std;
class bst
{
private:

    struct node
    {
        int data;
        node* left;
        node* right;
        node(int value)
        {
            data = value;
            left = right = nullptr;
        }
    };

    node* root = nullptr;
    

    void addhelper(node* temp, int value)
    {
        if (value <= temp->data)
        {
            if(temp->left == nullptr)
            {  
                temp->left = new node(value);
            }
            else
            {
                addhelper(temp->left, value);
            }
        }
        else
        {
            if(temp->right == nullptr)
            {   
                temp->right = new node(value);
            }
            else
            {
                addhelper(temp->right, value);
            }
        }
    }

//display other value in tree
    void preOrder(node* temp)
    {
        if (temp == nullptr)return;
        cout<<temp->data<<" ";
        preOrder(temp->left);
        preOrder(temp->right);
    }

//math the tree height
    int getheighthelper(node* temp)
    {
        if (temp == nullptr)
        return -1;

        int right_sub = getheighthelper(temp->right);
        int left_sub = getheighthelper(temp->left);
        return 1 + std::max(left_sub, right_sub);    
    }

//get secoun in the root
    int maxhelp(node* temp)
    {
        if (temp->right == nullptr)
        {
            return temp->data;
        }
        else
        {
            return maxhelp(temp->right);
        }
    }

//get first in the root 
    int minhelp(node* temp)
    {
        if (temp->left == nullptr)
        {
            return temp->data;
        }
        else
        {
            return maxhelp(temp->left);
        }
    }

    node* removehelper(node* root, int data)
    {
        if(root == nullptr)return root;
        else if(data < root->data)
            root->left =removehelper(root->left,data);
        else if(data > root->data)
            root->right =removehelper(root->right,data);
        else{
            if (root->left ==nullptr)
            {
                node* temp = root->right;
                delete root;
                return temp;
            }
            else if (root->right ==nullptr)
            {
                node* temp = root->left;
                delete root;
                return temp;
            }
            else{
                int maxvalue = this->maxhelp(root->left);
                root->data = maxvalue;
                root->left = removehelper(root->left,maxvalue);
            }
        }
        return root;
    }

public:

//add value in tree
    void add(int value)
    {
        if(root == nullptr)
        {    
            root = new node(value);
        }
        else
        {
            addhelper(root, value);
        }
    }

//desplay value in tree
    void display()
    {
        if(root==nullptr)return;

        queue<node*> q;
        q.push(root);
        
        while(!q.empty())
        {
            node* current = q.front();
            q.pop();
            cout<<current->data<<"\t";
            if(current->left != nullptr)q.push(current->left);
            if(current->right != nullptr)q.push(current->right);
        }
        cout<<endl;
    }

//display other value in tree
    void disOrder()
    {
        if (root != nullptr)
        preOrder(root);
    }

//math the tree height
    int getheight()
    {
        if  (root == nullptr)
            return -1;
        
        else
            return getheighthelper(root);
    }

//get secoun in the root
    int max()
    {
       return maxhelp(root); 
    }
    
//get first in the root    
    int min()
    {
       return minhelp(root); 
    }
    
    void remove (int data){
       root = removehelper(root, data); 
    }
};
int main()
{
    bst ob;
    ob.add(5);
    ob.add(10);
    ob.add(7);
    ob.add(1);
    ob.add(15);
    ob.add(100);

    ob.display();


    return 0;
}
