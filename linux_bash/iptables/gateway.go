package main

import (
	"encoding/binary"
	"fmt"
	"io"
	"net"
	"net/netip"
	"syscall"
	"unsafe"

	"golang.org/x/sys/unix"
)

func TCP_Server() {
	// 创建 TCP 服务器监听地址和端口
	listener, err := net.Listen("tcp", ":8000")
	if err != nil {
		fmt.Println("Error listening:", err.Error())
		return
	}
	defer listener.Close()

	fmt.Println("Server is listening on port 8000...")

	// 无限循环等待客户端连接
	for {
		// 等待连接
		conn, err := listener.Accept()
		if err != nil {
			fmt.Println("Error accepting connection:", err.Error())
			return
		}

		// 在新的 goroutine 中处理连接
		go handleConnection(conn)
	}
}

func UDP_Server() {
	addr, err := net.ResolveUDPAddr("udp", ":9000")
	if err != nil {
		fmt.Println("Error resolving address:", err.Error())
		return
	}

	conn, err := net.ListenUDP("udp", addr)
	if err != nil {
		fmt.Println("Error listening:", err.Error())
		return
	}
	defer conn.Close()

	fmt.Println("Server is listening on port 9000...")

	for {
		handleConnection_udp(conn)
	}

}
func handleConnection_udp(conn *net.UDPConn) {
	buffer := make([]byte, 4)
	_, remoteAddr, err := conn.ReadFromUDP(buffer)
	localAddr := conn.LocalAddr().String()
	if err != nil {
		fmt.Println("Error reading from connection:", err.Error())
		return
	}

	c := conn
	rc, err := c.SyscallConn()
	if err != nil {
		return
	}
	////获得原始目标地址
	rc.Control(func(fd uintptr) {
		xx := c.LocalAddr()
		_ = xx

		dst_addr, _ := getorigdst(fd)
		fmt.Printf("Udp Client connected from %s, local %s dst %s \n", remoteAddr.String(), localAddr, dst_addr.String())

	})

}

func main() {
	go TCP_Server()
	go UDP_Server()
	select {}
}

func echo(conn net.Conn) {
	buffer := make([]byte, 4)
	for {
		bytesRead, err := conn.Read(buffer)
		if err == io.EOF {
			// 如果遇到EOF，表示客户端关闭了连接，退出循环
			fmt.Println("Connection closed by client:")
			break
		} else if err != nil {
			// 如果读取数据出错，打印错误并退出循环
			fmt.Println("Error reading from connection:", err)
			break
		}

		// 将读取到的数据原样发送回客户端
		_, err = conn.Write(buffer[:bytesRead])
		if err != nil {
			// 如果发送数据出错，打印错误并退出循环
			fmt.Println("Error writing to connection:", err)
			break
		}
	}
}

const GETSOCKOPT = syscall.SYS_GETSOCKOPT
const SO_ORIGINAL_DST = 80

func socketcall(call, a0, a1, a2, a3, a4, a5 uintptr) error {
	if _, _, errno := syscall.Syscall6(call, a0, a1, a2, a3, a4, a5); errno != 0 {
		return errno
	}
	return nil
}

func getorigdst(fd uintptr) (netip.AddrPort, error) {
	addr := unix.RawSockaddrInet4{}
	size := uint32(unsafe.Sizeof(addr))
	if err := socketcall(GETSOCKOPT, fd, syscall.IPPROTO_IP, SO_ORIGINAL_DST, uintptr(unsafe.Pointer(&addr)), uintptr(unsafe.Pointer(&size)), 0); err != nil {
		return netip.AddrPort{}, err
	}
	port := binary.BigEndian.Uint16((*(*[2]byte)(unsafe.Pointer(&addr.Port)))[:])
	return netip.AddrPortFrom(netip.AddrFrom4(addr.Addr), port), nil
}
func handleConnection(conn net.Conn) {
	// 当函数返回时关闭连接
	defer conn.Close()

	// 获取远程客户端地址和端口信息
	remoteAddr := conn.RemoteAddr().String()
	localAddr := conn.LocalAddr().String()

	c, _ := conn.(*net.TCPConn)
	rc, err := c.SyscallConn()
	if err != nil {
		return
	}
	//获得原始目标地址
	rc.Control(func(fd uintptr) {
		if ip4 := c.LocalAddr().(*net.TCPAddr).IP.To4(); ip4 != nil {
			dst_addr, _ := getorigdst(fd)
			fmt.Printf("Client connected from %s, local %s dst %s \n", remoteAddr, localAddr, dst_addr.String())
		}

	})

	//echo(conn)
}
