<?php

class Application_Model_Account
{
    const ROLE_ACCOUNT_ADMIN = 'ACCOUNT_ADMIN';
    const ROLE_ACCOUNT_USER = 'ACCOUNT_USER';

    protected $account_id;
    protected $role;
    protected $name;
    protected $password;


    public function __construct(array $options = null) {
        if (is_array ( $options )) {
            $this->setOptions ( $options );
        }
    }

    public function __set($name, $value) {
        $method = 'set' . $name;
        if (('mapper' == $name) || ! method_exists ( $this, $method )) {
            throw new Exception ( 'Invalid article property' );
        }
        $this->$method ( $value );
    }

    public function __get($name) {
        $method = 'get' . $name;
        if (('mapper' == $name) || ! method_exists ( $this, $method )) {
            throw new Exception ( 'Invalid article property' );
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
    public function getAccountId()
    {
        return $this->account_id;
    }

    /**
     * @param mixed $account_id
     */
    public function setAccountId($account_id)
    {
        $this->account_id = $account_id;
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
     * @param mixed $name
     */
    public function setName($name)
    {
        $this->name = $name;
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
     */
    public function setPassword($password)
    {
        $this->password = $password;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getRole()
    {
        return $this->role;
    }

    /**
     * @param mixed $role
     */
    public function setRole($role)
    {
        $this->role = $role;
        return $this;
    }



}

