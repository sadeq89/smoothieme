<?php

class Application_Model_Account
{
    protected $account_id;
    protected $role;
    protected $name;
    protected $password;
    protected $salt;


    public function __construct(array $options = null) {
        if (is_array ( $options )) {
            $this->setOptions ( $options );
        }
    }

    public function __set($name, $value) {
        $method = 'set' . $name;
        if (('mapper' == $name) || ! method_exists ( $this, $method )) {
            throw new Exception ( 'Invalid account property' );
        }
        $this->$method ( $value );
    }

    public function __get($name) {
        $method = 'get' . $name;
        if (('mapper' == $name) || ! method_exists ( $this, $method )) {
            throw new Exception ( 'Invalid account property' );
        }
        return $this->$method ();
    }

    public function setOptions(array $options) {
        $methods = get_class_methods ( $this );
        foreach ( $options as $key => $value ) {
            $method = 'set' . ucfirst ( $key );
            if (in_array ( $method, $methods )) {
                $this->$method ( $value );
            }
        }
        return $this;
    }

    /**
     * @return mixed
     */
    public function getSalt()
    {
        return $this->salt;
    }

    /**
     * @param mixed $salt
     * @return $this
     */
    public function setSalt($salt)
    {

        if($salt != null) {
            $this->salt = $salt;
        }
        else
            $this->salt = 'saltsaltsalt';
        return $this;
    }

    

    /**
     * @return mixed
     */
    public function getAccountId()
    {
        return $this->account_id;
    }

    /**
     * @param mixed $account_id
     * @return $this
     */
    public function setAccountId($account_id)
    {
        if($account_id > 1 && $account_id != null && is_integer($account_id)) {
            $this->account_id = $account_id;
        }
        else
            echo "AccountID must be greater 0 or notNull!";
        return $this;
    }


    /**
     * @return mixed
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * @param String $name
     * @return $this
     */
    public function setName($name)
    {
        if($name != null && is_string($name)) {
            $this->name = $name;
        }
        else
            echo 'Name must be varchar and notNull!';
        return $this;
    }

    /**
     * @return mixed
     */
    public function getPassword()
    {
        return $this->password;
    }

    /**
     * @param mixed $password
     * @return $this
     */
    public function setPassword($password)
    {
        if($password != null) {
            $this->password = $password;
        }
        else
            echo 'Password must be set!';
        return $this;
    }

    /**
     * @return String
     */
    public function getRole()
    {
        return $this->role;
    }

    /**
     * @param String $role
     * @return $this
     */
    public function setRole($role)
    {
        $this->role = $role;
        return $this;
    }



}

