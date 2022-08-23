package com.ez.wonder.common;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class AdEmailSender {
	protected final JavaMailSender mailSender;

	public void sendEmail(String subject, String content, String receiver, String sender) throws MessagingException {
		InternetAddress[] receiverAddr = { new InternetAddress(receiver) };

		MimeMessage msg = mailSender.createMimeMessage();
		msg.setSubject(subject);
		msg.setText(content);
		msg.setRecipients(RecipientType.TO, receiverAddr);
		msg.setFrom(new InternetAddress(sender));
		mailSender.send(msg);
	}
}
